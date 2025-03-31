//
//  SideMenuView.swift
//  Raiva
//
//  Created by Dan Figueroa on 18/03/25.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var appData: AppData
    @StateObject var vm = SideMenuViewModel()
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        HStack {
            ZStack{
                Rectangle()
                    .fill(.verdeBosque)
                    .frame(width: 270)
                    .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 20) {
                    UserViewType(
                        imageName: (CurrentUser.shared.isLogged) ? CurrentUser.shared.profilePicture : "cool",
                        name: (CurrentUser.shared.isLogged) ? CurrentUser.shared.userName : "Invitado",
                        style: .vertical
                    )
                    .frame(width: appData.UISW * 0.23, height: appData.UISH * 0.15)
                    .padding(.bottom, 80)
                    
                    
                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        RowView(
                            isSelected: selectedSideMenuTab == row.rawValue,
                            imageName: row.iconName,
                            title: row.title
                        ) {
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
                        .foregroundColor(isSelected ? .arena : .beige)
                        .frame(width: 50, height: 40)
                }
                .frame(width: 40, height: 40)
                
                Text(title)
                    .font(.custom("Gagalin", size:22))
                    .foregroundColor(isSelected ? .arena : .beige)
                
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
        .frame(height: 80)
        .frame(width: 250)
        .background(isSelected ? Color.arena.opacity(0.2) : Color.beige.opacity(0.2))
        .cornerRadius(8)
    }
}

#Preview {
    SideMenuView(selectedSideMenuTab: .constant(0), presentSideMenu: .constant(true))
        .environmentObject(AppData())
}
