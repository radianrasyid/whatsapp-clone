//
//  WhatsappAuthProvider.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 19/08/24.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum WhatsappAuthState {
    case pending, loggedIn(WhatsappUserItem), loggedOut
}

enum WhatsappAuthError: Error {
    case accountCreationFailed(_ description: String)
    case failedToSaveUserInfo(_ description: String)
    case emailLoginFailed(_ description: String)
}

extension WhatsappAuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
             return description
        case .failedToSaveUserInfo(let description):
            return description
        case .emailLoginFailed(let description):
            return description
        }
    }
}

protocol WhatsappAuthProvider {
    static var shared: WhatsappAuthProvider { get }
    var authState: CurrentValueSubject<WhatsappAuthState, Never> { get }
    var currentUser: WhatsappUserItem { get set }
    func autoLogin() async
    func login(with email: String, password: String) async throws
    func createAccount(for username: String, with email: String, and password: String) async throws
    func logout() async throws
}

final class WhatsappAuthManager: WhatsappAuthProvider {
    var currentUser: WhatsappUserItem = WhatsappUserItem(uuid: "1", username: "radianrasyid", email: "radianrasyid@gmail.com")

    private init(){
        Task {
            await autoLogin()
        }
    }
    
    static let shared: WhatsappAuthProvider = WhatsappAuthManager()
    
    var authState = CurrentValueSubject<WhatsappAuthState, Never>(.pending)
    
    func autoLogin() async {
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        }else{
            fetchCurrentUserInfo()
        }
    }
    
    func login(with email: String, password: String) async throws {
        do{
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            fetchCurrentUserInfo()
            print("🔐 -> successfully signed in: \(authResult.user.email ?? "")")
        }catch{
            print("🔐 -> failed to sign into the account with email \(email): \(error.localizedDescription)")
            throw WhatsappAuthError.emailLoginFailed("\(error.localizedDescription)")
        }
    }
    
    func createAccount(for username: String, with email: String, and password: String) async throws {
        //INVOKE FIREBASE CREATE ACCOUNT METHOD: store user in our firebase auth
        
        //STORE THE NEW USER INFO IN OUR DATABASE
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let uuid = authResult.user.uid
            let newUser = WhatsappUserItem(uuid: uuid, username: username, email: email)
            try await saveUserInfoToDatabase(user: newUser)
            self.authState.send(.loggedIn(newUser))
        }catch{
            print("🔐 -> failed to create an account: \(error.localizedDescription)")
            throw WhatsappAuthError.accountCreationFailed(error.localizedDescription)
        }
    }
    
    func logout() async throws {
        do{
            try Auth.auth().signOut()
            authState.send(.loggedOut)
            print("🔐 -> successfully logged out!")
        }catch{
            print("🔐 -> something went wrong when logging out: \(error.localizedDescription)")
        }
    }
}

extension WhatsappAuthManager {
    private func saveUserInfoToDatabase(user: WhatsappUserItem) async throws {
        do{
            let userDictionary: [String: Any] = [.uuid: user.uuid, .username: user.username, .email: user.email]
            try await WhatsappFirebaseConstants.UserRef.child(user.uuid).setValue(userDictionary)
        }catch{
            print("🔐 -> failed to save an account to database: \(error.localizedDescription)")
            throw WhatsappAuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    
    private func fetchCurrentUserInfo(){
        guard let currentUserUuid = Auth.auth().currentUser?.uid else {return}
        WhatsappFirebaseConstants.UserRef.child(currentUserUuid).observe(.value){
            [weak self] snapshot in
            guard let userDictionary = snapshot.value as? [String: Any] else {return}
            let user = WhatsappUserItem(dictionary: userDictionary)
            self?.currentUser = user
            print("🔐 -> current logged in user: \(user.username)")
            self?.authState.send(.loggedIn(user))
        } withCancel: { Error in
            print("Faild to get current user info \(Error.localizedDescription)")
        }
    }
}
