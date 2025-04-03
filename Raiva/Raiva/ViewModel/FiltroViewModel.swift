//
//  FiltroViewModel.swift
//  Raiva
//
//  Created by Dan Figueroa on 02/04/25.
//

import Foundation
import SwiftUI

class FiltroViewModel: ObservableObject {
    @Published var showFilter = false
    @Published var filterOpacity = 0.0
    @Published var communities: [Community] = []
    private let connection: FirebaseConnectable
    private let forumService = ForumService()
    private let communityService = CommunityService()
    
    init(connection: FirebaseConnectable = FirebaseConnection.shared) {
        self.connection = connection
        getComunidadesOnce()
    }
    
    
    func getComunidadesOnce(){
        Task{
            do{
                let fetchComunidades = try await communityService.obtenerTodasLasComunidades()
                await MainActor.run{
                    self.communities = fetchComunidades
                }
            }catch{
                print("error")
            }
        }
    }
    
    
    func toggleFilter() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showFilter.toggle()
            filterOpacity = showFilter ? 1.0 : 0.0
        }
    }
    
    func hideFilter() {
        withAnimation(.easeInOut(duration: 0.3)) {
            filterOpacity = 0.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showFilter = false
        }
    }
}

struct FiltroOverlay: View {
    @ObservedObject var viewModel: FiltroViewModel
    var opciones: [String]
    var onSeleccion: (String) -> Void
    var offsetX: CGFloat
    var offsetY: CGFloat
    
    var body: some View {

        if viewModel.showFilter {
            Filtro(opciones: opciones) { opcion in
                print("Se seleccionó: \(opcion)")
                onSeleccion(opcion)
                viewModel.hideFilter()
            }
            .opacity(viewModel.filterOpacity)
            .offset(x: offsetX, y: offsetY)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.3)) {
                    viewModel.filterOpacity = 1.0
                }
            }
            .zIndex(2)
        }
    }
}
