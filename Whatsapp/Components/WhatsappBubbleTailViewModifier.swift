//
//  WhatsappBubbleTailViewModifier.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 13/08/24.
//

import Foundation
import SwiftUI

private struct WhatsappBubbleTailModifier: ViewModifier {
    var direction: WhatsappMessageDirection
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: direction == .received ? .bottomLeading : .bottomTrailing){
                WhatsappBubbleTailView(direction: direction)
            }
    }
}

func WhatsappTextBubbleColor(_ direction: WhatsappMessageDirection) -> Color {
    return direction == .sent ? .bubbleSent : .bubbleReceived
}

extension View {
    func applyTail(_ direction: WhatsappMessageDirection) -> some View {
        self.modifier(WhatsappBubbleTailModifier(direction: direction))
    }
}
