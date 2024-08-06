//
//  WhatsappCallsList.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 06/07/24.
//

import Foundation
import SwiftUI

struct WhatsappCallsList: View {
    var numberKnown: Bool
    var contactName: String
    var phoneNumber: String
    var callStatus: WhatsappCalls
    var infoAction: () -> Void
    var body: some View {
        VStack{
            
            HStack{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading){
                    if(numberKnown){
                        Text(contactName)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }else{
                        Text(phoneNumber)
                            .foregroundStyle(Color(.red))
                        Text("~\(contactName)")
                            .foregroundStyle(Color(.red))
                    }
                    
                    switch (callStatus){
                    case .incoming:
                        Text("Incoming")
                    case .missed:
                        Text("Missed")
                    case .outgoing:
                        Text("Outgoing")
                    }
                }
                
                Spacer()
                
                Text("11.59")
                
                Button(action: infoAction, label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(Color(.label))
                })
            }
        }
        
    }
}
