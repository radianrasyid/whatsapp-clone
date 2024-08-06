//
//  WhatsappContactViewTopPart.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 07/07/24.
//

import Foundation
import SwiftUI

struct WhatsappContactViewTopPart: View {
    
    var userName: String
    var phoneNumber: String
    
    var body: some View {
        Image(systemName: "person.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 70, height: 70)
        
        Text(userName)
            .font(.title)
            .fontWeight(.bold)
        
        Text(phoneNumber)
            .font(.subheadline)
            .foregroundStyle(Color(.systemGray3))
    }
}
