//  Community.swift
//  Raiva
//
//  Created by Jesus Ortega on 19/03/25.
//

import Foundation

struct Community: Codable, Hashable {
    var id: String
    var communityName: String
    var communityDescription: String
    var communityProfieImage: String
    var communityPortraitImage: String
}
