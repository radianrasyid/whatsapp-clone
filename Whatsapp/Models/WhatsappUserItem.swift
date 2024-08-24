//
//  WhatsappUserItem.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 19/08/24.
//

import Foundation


struct WhatsappUserItem: Identifiable, Hashable, Decodable {
    let uuid: String
    let username: String
    let email: String
    var bio: String? = nil
    var profileImageUrl: String? = nil
    
    var id: String {
        return uuid
    }
    
    var bioUnwrapped: String {
        return bio ?? "Hey there, I'm using Whatsapp!"
    }
    
    static var placeholder = WhatsappUserItem(uuid: UUID().uuidString, username: "radianrasyid", email: "radian.rasyid9@gmail.com", bio: "Hey there, I'm using Whatsapp")
    
    static var users: [WhatsappUserItem] = [
        WhatsappUserItem(uuid: UUID().uuidString, username: "radian rasyid", email: "radian.rasyid9@gmail.com", bio: "Hey there, I'm using Whatsapp"),
        WhatsappUserItem(uuid: UUID().uuidString, username: "john doe", email: "john.doe@example.com", bio: "Living the dream"),
        WhatsappUserItem(uuid: UUID().uuidString, username: "janedee", email: "janedoe@example.com", bio: "Chatting is life"),
        WhatsappUserItem(uuid: UUID().uuidString, username: "radianrasyid", email: "radian.rasyid9@icloud.com", bio: "WhatsApp is love"),
        WhatsappUserItem(uuid: UUID().uuidString, username: "emily watson", email: "emily.watson@example.com", bio: "Always online"),
        WhatsappUserItem(uuid: UUID().uuidString, username: "michaelbrown", email: "michael.brown@example.com", bio: "Loving this app"),
        WhatsappUserItem(uuid: UUID().uuidString, username: "sarah connor", email: "sarah.connor@example.com", bio: "Catch me if you can"),
        WhatsappUserItem(uuid: UUID().uuidString, username: "johnnybravo", email: "johnny.bravo@example.com", bio: "I'm the king of chat"),
        WhatsappUserItem(uuid: UUID().uuidString, username: "mariasmith", email: "maria.smith@example.com", bio: "Living my best chat life"),
        WhatsappUserItem(uuid: UUID().uuidString, username: "peter parker", email: "peter.parker@example.com", bio: "Just swinging by"),
    ]
}

extension WhatsappUserItem {
    init(dictionary: [String: Any]){
        self.uuid = dictionary[.uuid] as? String ?? ""
        self.username = dictionary[.username] as? String ?? ""
        self.email = dictionary[.email] as? String ?? ""
        self.bio = dictionary[.bio] as? String ?? nil
        self.profileImageUrl = dictionary[.profileImageUrl] as? String ?? nil
        
    }
}

extension String {
    static let uuid = "uid"
    static let username = "username"
    static let email = "email"
    static let bio = "bio"
    static let profileImageUrl = "profileImageUrl"
}
