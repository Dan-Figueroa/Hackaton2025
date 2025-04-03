//
//  CommunityForumsViewModel.swift
//  Raiva
//
//  Created by Jesus Ortega on 03/04/25.
//

import Foundation
import Combine

import Foundation
import Combine

class CommunityForumsViewModel: ObservableObject {
    @Published var forums: [Forum] = []
    @Published private var users: [User] = []
    @Published private(set) var currentCommunity: Community?
    
    private var usersDict: [String: User] = [:]
    private let forumService = ForumService()
    private let userService = UserService()
    private let communityService = CommunityService()
    private var cancellables = Set<AnyCancellable>()
    private let communityID: String
    
    init(communityID: String) {
        self.communityID = communityID
        setupObservers()
        loadData()
    }
    
    private func setupObservers() {
        $users.sink { [weak self] users in
            self?.usersDict = Dictionary(uniqueKeysWithValues: users.map { ($0.id, $0) })
        }.store(in: &cancellables)
    }
    
     func loadData() {
        loadForums()
        loadUsers()
        loadCommunity()
    }
    
    private func loadForums() {
        forumService.observarForosEnTiempoReal { [weak self] foros in
            DispatchQueue.main.async {
                self?.forums = foros.filter { $0.communityID == self?.communityID }
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
    
    private func loadCommunity() {
        Task {
            do {
                let comunidades = try await communityService.obtenerTodasLasComunidades()
                await MainActor.run {
                    self.currentCommunity = comunidades.first { $0.id == self.communityID }
                }
            } catch {
                print("Error loading community:", error)
            }
        }
    }
    
    func getDisplayData(for forum: Forum) -> (user: User, community: Community)? {
        guard let user = usersDict[forum.userID],
              let community = currentCommunity else { return nil }
        return (user, community)
    }
}
