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
