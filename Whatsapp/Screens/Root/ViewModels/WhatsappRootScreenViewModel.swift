//
//  WhatsappRootScreenViewModel.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 19/08/24.
//
import Foundation
import Combine

@Observable
class WhatsappRootScreenViewModel {
    private(set) var authState: WhatsappAuthState = .pending
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = WhatsappAuthManager.shared.authState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] latestAuthState in
                self?.authState = latestAuthState
            }
    }
}
