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
        
//        Task {
//            await registerTestAccounts()
//        }
    }
//    
//    deinit {
//        cancellable?.cancel()
//    }
//    
//    @MainActor
//    private func registerTestAccounts() async {
//        for email in WhatsappAuthManager.testAccounts {
//            let username = email.replacingOccurrences(of: "@gmail.com", with: "")
//            do {
//                try await WhatsappAuthManager.shared.createAccount(for: username, with: email, and: "radian12345678")
//            } catch {
//                print("Failed to register test account: \(error.localizedDescription)")
//            }
//        }
//    }
}
