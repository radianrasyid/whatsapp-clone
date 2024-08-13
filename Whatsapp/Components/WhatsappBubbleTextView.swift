//
//  WhatsappBubbleTextView.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 13/08/24.
//

import SwiftUI

//BubbleImageView, BubbleVoiceView
struct WhatsappBubbleTextView: View {
    let item: WhatsappMessageItemViewModel
    var body: some View {
        VStack(alignment: item.horizontalAlignment){
            Text(item.text)
                .padding(10)
                .background(WhatsappTextBubbleColor(item.direction))
                .clipShape(.rect(cornerRadius: 10, style: .continuous))
                .applyTail(item.direction)
            
            timeStampTextView(item.status, direction: item.direction)
        }
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading, item.direction == .received ? 5 : 100)
        .padding(.trailing, item.direction == .received ? 100 : 5)
    }
    
    private func timeStampTextView(_ messageStatus: WhatsappConnectionStatus, direction: WhatsappMessageDirection) -> some View {
        HStack{
            Text("3:05 PM")
                .font(.caption)
                .foregroundStyle(Color(.systemGray))
            
            if(direction == .sent){
                senderStatusState(status: item.status)
            }
        }
    }
}

#Preview {
    ScrollView{
        WhatsappBubbleTextView(item: WhatsappMessageItemViewModel(text: "Halo ini dari mamacedon", direction: .received, type: .text, status: .sent))
        WhatsappBubbleTextView(item: WhatsappMessageItemViewModel(text: "Halo ini dari mamacedon", direction: .sent, type: .text, status: .sent))
    }
}
