//
//  Comment.swift
//  Raiva
//
//  Created by Jesus Ortega on 19/03/25.
//

import Foundation

struct Comment: Codable, Hashable{
    var user: User
    var forum: Forum
    var tittle: String
    var body: String
}
