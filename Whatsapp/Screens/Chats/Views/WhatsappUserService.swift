//
//  WhatsappUserService.swift
//  Whatsapp
//
//  Created by Radian Rasyid on 21/08/24.
//

import Foundation
import Firebase
import FirebaseDatabase

struct WhatsappUserService {
    static func paginateUsers(lastCursor: String?, pageSize: UInt) async throws -> WhatsappUserNode {
        let mainSnapshot: DataSnapshot
        if lastCursor == nil {
            mainSnapshot = try await WhatsappFirebaseConstants.UserRef.queryLimited(toLast: pageSize).getData()
        }else{
            mainSnapshot = try await WhatsappFirebaseConstants.UserRef.queryOrderedByKey().queryEnding(atValue: lastCursor)
                .queryLimited(toLast: pageSize + 1)
                .getData()
        }
        
        guard let first = mainSnapshot.children.allObjects.first as? DataSnapshot, let allObjects = mainSnapshot.children.allObjects as? [DataSnapshot] else {
                        return .emptyNode
                    }
        
                    let users: [WhatsappUserItem] = allObjects.compactMap{
                        usersnapshot in
                        let userDict = usersnapshot.value as? [String: Any] ?? [:]
                        return WhatsappUserItem(dictionary: userDict)
                    }
        
                    if users.count == mainSnapshot.childrenCount {
                        let filteredUser = lastCursor == nil ? users : users.filter{$0.uuid != lastCursor}
                        let userNode = WhatsappUserNode(users: filteredUser, currentCursor: first.key)
                        return userNode
                    }
        
        return .emptyNode
    }
//    static func paginateUsers(lastCursor: String?, pageSize: UInt) async throws -> WhatsappUserNode {
//        if(lastCursor == nil){
//            //initial data fetch
//            let mainSnapshot = try await WhatsappFirebaseConstants.UserRef.queryLimited(toLast: pageSize).getData()
//            guard let first = mainSnapshot.children.allObjects.first as? DataSnapshot, let allObjects = mainSnapshot.children.allObjects as? [DataSnapshot] else {
//                return .emptyNode
//            }
//            
//            let users: [WhatsappUserItem] = allObjects.compactMap{
//                usersnapshot in
//                let userDict = usersnapshot.value as? [String: Any] ?? [:]
//                return WhatsappUserItem(dictionary: userDict)
//            }
//            
//            if users.count == mainSnapshot.childrenCount {
//                let userNode = WhatsappUserNode(users: users, currentCursor: first.key)
//                return userNode
//            }
//            
//            return .emptyNode
//        }else{
//            //paginate for more data
//            let mainSnapshot = try await WhatsappFirebaseConstants.UserRef
//                .queryOrderedByKey()
//                .queryEnding(atValue: lastCursor)
//                .queryLimited(toLast: pageSize + 1)
//                .getData()
//            
//            guard let first = mainSnapshot.children.allObjects.first as? DataSnapshot,
//                  let allObjects = mainSnapshot.children.allObjects as? [DataSnapshot] else {return .emptyNode}
//            
//            let users: [WhatsappUserItem] = allObjects.compactMap{
//                userSnapshot in
//                let userDict = userSnapshot.value as? [String: Any] ?? [:]
//                return WhatsappUserItem(dictionary: userDict)
//            }
//            
//            if users.count == mainSnapshot.childrenCount {
//                let filteredUsers = users.filter {
//                    $0.uuid != lastCursor
//                }
//                let userNode = WhatsappUserNode(users: filteredUsers, currentCursor: first.key)
//                return userNode
//            }
//            
//            return .emptyNode
//        }
//    }
}

struct WhatsappUserNode {
    var users: [WhatsappUserItem]
    var currentCursor: String?
    static let emptyNode = WhatsappUserNode(users: [], currentCursor: nil)
}

