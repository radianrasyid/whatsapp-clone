//
//  ContentView.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/07/24.
//

import SwiftUI
import SwiftData

struct WhatsappMainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var viewModel = WhatsappMainViewModel()
    
    init(){
        UITabBarItem.appearance().badgeColor = .systemGreen
        UITabBarItem.appearance().setBadgeTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .application)
    }
    
    var body: some View {
        TabView{
            ForEach(viewModel.TabItems, id: \.id){
                item in
                item.content
                    .tabItem {
                        VStack{
                            Image(systemName: item.image)
                            Text(item.title)
                                .font(.footnote)
                        }
                    }
                    .badge(item.title == "Settings" ? 1 : 0)
                
                    .tint(Color(.systemGreen))
            }
        }
        .tint(Color(.label))
    }
}

#Preview {
    WhatsappMainView()
        .modelContainer(for: Item.self, inMemory: true)
}
