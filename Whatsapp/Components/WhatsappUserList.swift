//
//  WhatsappUserList.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 06/07/24.
//

import Foundation
import SwiftUI

struct WhatsappUserList: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
            VStack(alignment: .leading) {
                Text("My Status")
                    .font(.body)
                    .fontWeight(.semibold)
                Text("Add to my status")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            HStack(spacing: 5) {
                Button {
                    // Action
                } label: {
                    Image(systemName: "camera.fill")
                }
                .frame(width: 40, height: 40)
                .background(Color(.systemGray5))
                .foregroundStyle(Color(.label))
                .clipShape(Circle())
                
                Button {
                    // Action
                } label: {
                    Image(systemName: "pencil")
                }
                .frame(width: 40, height: 40)
                .background(Color(.systemGray5))
                .foregroundStyle(Color(.label))
                .clipShape(Circle())
            }
        }
    }
}
