//
//  MisComunidadesViewModel.swift
//  Raiva
//
//  Created by Jesus Ortega on 03/04/25.
//

import Foundation
import Combine

class MisComunidadesViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var forumUsers: [ForumUsers] = []
    @Published private var users: [User] = []
    @Published private var communities: [Community] = []
    
    // Diccionarios para acceso rápido
    private var usersDict: [String: User] = [:]
    private var communitiesDict: [String: Community] = [:]
    
    // MARK: - Services
    private let forumUsersService = ForumUsersService()
    private let userService = UserService()
    private let communityService = CommunityService()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init() {
        setupDataObservers()
        loadInitialData()
    }
    
    // MARK: - Setup
    private func setupDataObservers() {
        // Actualizar diccionarios cuando cambien los arrays
        $users.sink { [weak self] users in
            self?.usersDict = Dictionary(uniqueKeysWithValues: users.map { ($0.id, $0) })
        }.store(in: &cancellables)
        
        $communities.sink { [weak self] communities in
            self?.communitiesDict = Dictionary(uniqueKeysWithValues: communities.map { ($0.id, $0) })
        }.store(in: &cancellables)
    }
    
    // MARK: - Data Loading
    func loadInitialData() {
        loadForumUsers()
        loadUsers()
        loadCommunities()
    }
    
    private func loadForumUsers() {
        forumUsersService.observarForumUsersEnTiempoReal { [weak self] forumUsers in
            DispatchQueue.main.async {
                self?.forumUsers = forumUsers
            }
        }
    }
    
    private func loadUsers() {
        userService.observarUsuariosEnTiempoReal { [weak self] usuarios in
            DispatchQueue.main.async {
                self?.users = usuarios
            }
        }
    }
    
    private func loadCommunities() {
        Task {
            do {
                let communities = try await communityService.obtenerTodasLasComunidades()
                await MainActor.run {
                    self.communities = communities
                }
            } catch {
                print("Error cargando comunidades: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Public Methods
    func getCommunityUserDisplayData(for forumUser: ForumUsers) -> (user: User, community: Community)? {
        guard let user = usersDict[forumUser.userID],
              let community = communitiesDict[forumUser.forumID] else {
            print("No se encontró usuario o comunidad para el ForumUser \(forumUser.id)")
            return nil
        }
        return (user, community)
    }
    
    // Método para obtener todos los usuarios de una comunidad específica
    func getUsersForCommunity(communityID: String) -> [User] {
        let usersInCommunity = forumUsers.filter { $0.forumID == communityID }
        return usersInCommunity.compactMap { usersDict[$0.userID] }
    }
    
    // Método para obtener todas las comunidades de un usuario específico
    func getCommunitiesForUser(userID: String) -> [Community] {
        let communitiesForUser = forumUsers.filter { $0.userID == userID }
        return communitiesForUser.compactMap { communitiesDict[$0.forumID] }
    }
    
    // Método para subir una nueva relación usuario-comunidad
    func subirForumUser(fu: ForumUsers) {
        forumUsersService.guardarForumUsers(forumUsers: fu)
    }
    
    // Método adicional: verificar si un usuario pertenece a una comunidad
    func userBelongsToCommunity(userID: String, communityID: String) -> Bool {
        return forumUsers.contains { $0.userID == userID && $0.forumID == communityID }
    }
}
