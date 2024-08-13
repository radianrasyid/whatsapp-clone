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
        HStack{
            if item.direction == .sent {Spacer()}
            
            HStack{
                if item.direction == .sent { shareButton() }
                
                messageTextView()
                    .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
                    .overlay(alignment: .center){
                        playButton()
                            .opacity(item.type == .image ? 0 : 1)
                    }
                
                if item.direction == .received {shareButton()}
            }
            
            if item.direction == .received {Spacer()}
        }
    }
    
    private func messageTextView() -> some View {
        VStack(alignment: .leading, spacing: 0){
            Image(.chatImageSample)
                .resizable()
                .scaledToFill()
                .frame(width: 230, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.systemGray6))
                }
                .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color(.systemGray6)))
                .overlay(alignment: .bottomTrailing){
                    timeStampTextView(item)
                        .padding(.horizontal, 5)
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 20))
                        .padding(10)
                }
                .padding(5)
            
            Text(item.text)
                .padding([.horizontal, .bottom], 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(width: 220)
        }
        .background(item.direction == .sent ? .bubbleSent : .bubbleReceived)
        .clipShape(.rect(cornerRadius: 10, style: .continuous))
        .applyTail(item.direction)
    }
    
    
    private func shareButton() -> some View {
        Button(action: {}, label: {
            Image(systemName: "arrowshape.turn.up.right.fill")
                .padding(10)
                .foregroundStyle(Color.gray)
                .background(.thinMaterial)
                .clipShape(Circle())
        })
    }
    
    private func timeStampTextView(_ item: WhatsappMessageItemViewModel) -> some View {
        HStack(spacing: 5){
            Text("11:30 AM")
                .font(.caption)
            
            if item.direction == .sent {
                senderStatusImageState(status: item.status)
            }
        }
    }
    
    private func playButton() -> some View {
        Image(systemName: "play.fill")
            .padding()
            .imageScale(.large)
            .foregroundStyle(.gray)
            .background(.thinMaterial)
            .clipShape(Circle())
    }
}

#Preview {
    ScrollView{
        WhatsappBubbleImageView(item: WhatsappMessageItemViewModel(text: "Hello", direction: .sent, type: .image, status: .sent))
        WhatsappBubbleImageView(item: WhatsappMessageItemViewModel(text: "Hello", direction: .received, type: .video, status: .sent))
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal)
    .background(Color.gray.opacity(0.4))
}
