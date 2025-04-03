//
//  EtniasEnum.swift
//  Raiva
//
//  Created by Jesus Ortega on 18/03/25.
//

enum EtniasEnum: String, CaseIterable {
    case zoque = "Zoque"
    case tsotsil = "Tzotzil"
    case chol = "Chol"
    case tseltal = "Tzeltal"
    case tojolabal = "Tojolabal"
    case chuj = "Chuj"
    case qanjobal = "Q'anjob'al"
    case mam = "Mam"
    
    
    var imageName: String {
        switch self {
        case .zoque: return "zoque"
        case .tsotsil: return "tsotsil"
        case .chol: return "chol"
        case .tseltal: return "tseltal"
        case .tojolabal: return "tojolabal"
        case .chuj: return "chuj"
        case .qanjobal: return "qanjobal"
        case .mam: return "mam"
        }
    }
}
enum genderEnum: String, CaseIterable{
    case woman = "Woman"
    case man = "Man"
}

func getModel(etnia: EtniasEnum, gender: genderEnum) -> String{
    return "\(etnia.rawValue)_\(gender.rawValue)"
}
