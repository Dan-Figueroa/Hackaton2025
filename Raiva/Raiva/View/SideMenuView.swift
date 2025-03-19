//
//  SideMenuView.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var appData: AppData
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.verdeBosque)
                    .frame(width: 270)
                    .shadow(color: .arena, radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 20) {
                    UserViewType(imageName: "perfilInvitado", name: "Meliza Ortega", style: .vertical)
                        .frame(width: appData.UISW * 0.23, height: appData.UISH * 0.15)
                    .padding(.bottom, 80)
                    
                    
                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                            selectedSideMenuTab = row.rawValue
                            presentSideMenu.toggle()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.verdeBosque
                )
            }
            Spacer()
        }
        .background(.clear)
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View {
        
        Button {
            action()
        } label: {
            HStack(spacing: 20) {
                ZStack {
                    Image(systemName: imageName)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(isSelected ? .arena : .beige) // Cambia el color del ícono
                        .frame(width: 50, height: 40)
                }
                .frame(width: 40, height: 40)
                
                Text(title)
                    .font(.custom("Gagalin", size:22))
                    .foregroundColor(isSelected ? .arena : .beige) // Cambia el color del texto
                
                Spacer()
            }
            .padding(.vertical, 10) // Espaciado vertical dentro del botón
            .padding(.horizontal, 20) // Espaciado horizontal
        }
        .frame(height: 80)
        .frame(width: 250) // Hace que el botón ocupe todo el ancho disponible
        .background(isSelected ? Color.arena.opacity(0.2) : Color.beige.opacity(0.2)) // Color sólido
        .cornerRadius(8) // Bordes redondeados
    }
}
