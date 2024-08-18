//
//  WhatsappBubbleAudioView.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 14/08/24.
//

import Foundation
import SwiftUI


struct WhatsappBubbleAudioView: View {
    var item: WhatsappMessageItemViewModel
    @State private var sliderValue: Double = 0
    @State private var sliderRange: ClosedRange<Double> = 0...20
    var body: some View {
        VStack(alignment: item.horizontalAlignment){
            HStack{
                playButton()
                Slider(value: $sliderValue, in: sliderRange)
                Text("04:00")
                    .font(.subheadline)
            }
            .padding(10)
            .background(Color.gray.opacity(0.5))
            .clipShape(.rect(cornerRadius: 16, style: .continuous))
            .padding(5)
            .background(item.backgroundColor)
            .clipShape(.rect(cornerRadius: 16))
            .applyTail(item.direction)
            
            timeStampTextView(item.status, direction: item.direction)
        }
        .frame(maxWidth: .infinity, alignment: item.alignment)
        .padding(.leading, item.direction == .received ? 5 : 100)
        .padding(.trailing, item.direction == .received ? 100 : 5)
        .onAppear{
            let thumbImage = UIImage(systemName: "circle.fill")
            thumbImage?.configuration?.accessibilityFrame = CGRect(x: 9, y: 9, width: 15, height: 15)
            UISlider.appearance().setThumbImage(thumbImage, for: .normal)
            UISlider.appearance().thumbTintColor = .lightGray
        }
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
    
    private func playButton() -> some View {
        Button(action: {}, label: {
            Image(systemName: "play.fill")
                .foregroundStyle(item.direction == .sent ? .black : .white)
                .padding(10)
                .background(item.direction == .received ? .bubbleSent : .bubbleReceived)
                .clipShape(Circle())
        })
    }
}

#Preview {
    ScrollView{
        WhatsappBubbleAudioView(item: WhatsappMessageItemViewModel.stubMessages[2])
        WhatsappBubbleAudioView(item: WhatsappMessageItemViewModel.stubMessages[1])
    }
    .frame(maxWidth: .infinity)
    .padding()
}
