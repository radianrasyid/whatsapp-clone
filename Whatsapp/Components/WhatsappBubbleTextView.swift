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
                switch(messageStatus){
                case .failed:
                    Image(systemName: "exclamationmark.circle.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(Color(.systemRed))
                case .read:
                    Image(.seen)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 15, height: 15)
                        .foregroundStyle(Color.blue)
                case .received:
                    Image(.seen)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 15, height: 15)
                        .foregroundStyle(Color(.systemGray))
                case .sent:
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 10, height: 7)
                }
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
