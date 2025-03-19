//
//  Forum.swift
//  Raiva
//
//  Created by Jesus Ortega on 19/03/25.
//

import Foundation

struct Forum: Codable, Hashable {
    var idUser: String
    var idCommunity: String
    var title: String
    var body: String
    var likes: Int = 0
    var commentAmount: Int = 0
    var comment: [Comment]?
}
