//
//  SideMenuRowType.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//

import Foundation

enum SideMenuRowType: Int, CaseIterable{
    case principal
    case foro
    case informate
    case juguemos
    
    var title: String{
        switch self {
        case .principal:
            return "Principal"
        case .foro:
            return "Foro"
        case .informate:
            return "Informate"
        case .juguemos:
            return "Juguemos!!"
        }
    }
    
    var iconName: String{
        switch self {
        case .principal:
            return "house.fill"
        case .foro:
            return "message.badge.filled.fill"
        case .informate:
            return "book.fill"
        case .juguemos:
            return "gamecontroller.fill"
        }
    }
}
