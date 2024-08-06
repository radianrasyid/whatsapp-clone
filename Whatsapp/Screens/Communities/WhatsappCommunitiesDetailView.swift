//
//  WhatsappCommunitiesDetailView.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 11/07/24.
//

import Foundation
import SwiftUI

struct WhatsappCommunitiesDetailView: View {
    var community: Community
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                VStack(alignment: .leading){
                    
                }
            }
            .navigationTitle("\(community.name)")
        }
    }
}
