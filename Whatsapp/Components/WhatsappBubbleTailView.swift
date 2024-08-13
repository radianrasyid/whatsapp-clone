//
//  WhatsappBubbleTailView.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 13/08/24.
//

import SwiftUI

struct WhatsappBubbleTailView: View {
    var direction: WhatsappMessageDirection
    
    private var backgroundColor: Color {
        return direction == .sent ? .bubbleSent : .bubbleReceived
    }
    
    var body: some View {
        Image(direction == .sent ? .outgoingTail : .incomingTail)
            .renderingMode(.template)
            .resizable()
            .frame(width: 10, height: 10)
            .offset(y: 3)
            .foregroundStyle(backgroundColor)
    }
}

#Preview {
    WhatsappBubbleTailView(direction: .random)
}
