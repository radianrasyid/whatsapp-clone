//
//  WhatsappSelectedChatPartnerView.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 21/08/24.
//

import SwiftUI

struct WhatsappSelectedChatPartnerView: View {
    @Binding var viewModel: WhatsappChatPartnerPickerViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack{
                ForEach(viewModel.selectedChatPartners, id: \.id){
                    item in
                    chatPartnerItemView(item)
                }
            }
        }
    }
    
    private func chatPartnerItemView(_ user: WhatsappUserItem) -> some View{
        VStack{
            Circle()
                .frame(width: 60, height: 60)
                .overlay(alignment: .topTrailing){
                    Button(action: {
                        viewModel.handleItemSelection(user)
                    }, label: {
                        Image(systemName: "xmark")
                            .imageScale(.small)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .padding(5)
                            .background(Color(.systemGray2))
                            .clipShape(Circle())
                    })
                }
            
            Text(user.username)
                .font(.footnote)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    WhatsappSelectedChatPartnerView(viewModel: .constant(WhatsappChatPartnerPickerViewModel()))
}
