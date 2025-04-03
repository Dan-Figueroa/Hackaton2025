//
//  ForumUsers.swift
//  Raiva
//
//  Created by Jesus Ortega on 03/04/25.
//

import Foundation

struct ForumUsers: Codable, Hashable{
    var id: String = ""
    var userID: String
    var forumID: String
    var members: Int = 0
}
