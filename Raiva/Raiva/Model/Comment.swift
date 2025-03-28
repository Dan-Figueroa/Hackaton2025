//
//  Comment.swift
//  Raiva
//
//  Created by Jesus Ortega on 19/03/25.
//

import Foundation

struct Comment: Codable, Hashable{
    var id: String = ""
    var userID: String
    var forumID: String
    var title: String
    var body: String
    
    
}
