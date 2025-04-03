//
//  ForumDisplayViewModel.swift
//  Raiva
//
//  Created by Jesus Ortega on 02/04/25.
//

import Foundation
import Combine

class ForumDisplayViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var forums: [Forum] = []
    @Published private var users: [User] = []
    @Published private var communities: [Community] = []
    @Published var misForos: [Forum] = []
    @Published var forosPopulares: [Forum] = []
    
    // Diccionarios para acceso rápido
    private var usersDict: [String: User] = [:]
    private var communitiesDict: [String: Community] = [:]
    
    // MARK: - Services
    private let forumService = ForumService()
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
    private func loadInitialData() {
        loadForums()
        loadUsers()
        loadCommunities()
    }
    
    private func loadForums() {
        forumService.observarForosEnTiempoReal { [weak self] foros in
            DispatchQueue.main.async {
                self?.forums = foros
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
                let comunidades = try await communityService.obtenerTodasLasComunidades()
                await MainActor.run {
                    self.communities = comunidades
                }
            } catch {
                print("Error cargando comunidades: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Public Methods
    func getForumDisplayData(for forum: Forum) -> (user: User, community: Community)? {
        guard let user = usersDict[forum.userID],
              let community = communitiesDict[forum.communityID] else {
            print("No se encontró usuario o comunidad para el foro \(forum.id)")
            return nil
        }
        return (user, community)
    }
}
