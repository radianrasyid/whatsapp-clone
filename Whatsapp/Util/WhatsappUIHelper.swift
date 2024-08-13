//
//  WhatsappUIHelper.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 13/08/24.
//

import Foundation
import SwiftUI

func senderStatusState(status: WhatsappConnectionStatus) -> some View {
    switch(status){
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
            .foregroundStyle(Color(.systemGray))
    }
}

func senderStatusImageState(status: WhatsappConnectionStatus) -> some View {
    switch(status){
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
            .foregroundStyle(Color(.darkGray))
    }
}
