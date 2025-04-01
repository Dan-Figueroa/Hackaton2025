//
//  Forum.swift
//  Raiva
//
//  Created by Jesus Ortega on 19/03/25.
//
    
import Foundation

struct Forum: Codable, Hashable {
    var id: String = ""
    var userID: String
    var communityID: String
    var title: String
    var body: String
    var likes: Int = 0
    var commentCount: Int = 0
}
