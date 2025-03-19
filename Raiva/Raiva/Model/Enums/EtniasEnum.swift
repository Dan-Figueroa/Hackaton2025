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
    case qanjobal = "Qanjobal"
    case mam = "Mam"
}
enum genderEnum: String, CaseIterable{
    case woman = "Woman"
    case man = "Man"
}

func getModel(etnia: EtniasEnum, gender: genderEnum) -> String{
    return "\(etnia.rawValue)_\(gender.rawValue)"
}
