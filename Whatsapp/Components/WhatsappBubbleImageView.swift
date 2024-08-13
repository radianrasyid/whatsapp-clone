//
//  WhatsappBubbleImageView.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 13/08/24.
//

import SwiftUI

struct WhatsappBubbleImageView: View {
    let item: WhatsappMessageItemViewModel
    var body: some View {
        Text(item.text)
    }
}

#Preview {
    WhatsappBubbleImageView(item: WhatsappMessageItemViewModel.stubMessages[0])
}
