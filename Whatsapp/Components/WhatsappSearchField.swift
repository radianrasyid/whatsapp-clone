//
//  WhatsappSearchField.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 06/07/24.
//

import Foundation
import SwiftUI

struct WhatsappSearchField: View {
    @Binding var searchValue: String
    var placeholder: String = "Search"
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            TextField(placeholder, text: $searchValue)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(8)
    }
}
