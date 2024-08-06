//
//  WhatsappUserStoryThumbnail.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/07/24.
//

import Foundation
import SwiftUI

struct WhatsappUserStoryThumbnail: View {
    var contactName: String = ""
    var body: some View {
        VStack(spacing: 10){
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            Text(contactName)
                .font(.subheadline)
        }
    }
}

#Preview {
    WhatsappUserStoryThumbnail()
}
