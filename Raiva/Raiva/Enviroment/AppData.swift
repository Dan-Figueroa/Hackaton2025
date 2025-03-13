//
//  AppData.swift
//  Raiva
//
//  Created by Jesus Ortega on 13/03/25.
//

import Combine
import SwiftUI

class AppData: ObservableObject {
    @Published var UISW: CGFloat = UIScreen.main.bounds.width
    @Published var UISH: CGFloat = UIScreen.main.bounds.height
}

// MARK: - USO DE AppData: ObservableObject

/// Para visualizar los datos en previews:         .environmentObject(AppData())
/// Para usar las variables de AppData:            @EnvironmentObject var appData: AppData
