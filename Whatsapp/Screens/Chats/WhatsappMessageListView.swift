//
//  WhatsappMessageListView.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 13/08/24.
//

import SwiftUI

struct WhatsappMessageListView: UIViewControllerRepresentable {
    typealias UIViewControllerType = WhatsappMessageListController
    
    func makeUIViewController(context: Context) -> WhatsappMessageListController {
        let messageListController = WhatsappMessageListController()
        return messageListController
    }
    
    func updateUIViewController(_ uiViewController: WhatsappMessageListController, context: Context) {}
}

#Preview {
    WhatsappMessageListView()
}
