//
//  ForoData.swift
//  Raiva
//
//  Created by Dan Figueroa on 29/03/25.
//
import Foundation

class AltaForoViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var selectedEthnicity: EtniasEnum = .zoque
    @Published var postTitle: String = ""
    @Published var postContent: String = ""

    var selectedCommunityName: String {
        selectedEthnicity.rawValue
    }
}
