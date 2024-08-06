//
//  WhatsappCallsDetailViewModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/08/24.
//

import Foundation
import SwiftUI

@Observable class WhatsappCallsDetailViewModel {
    var lockChat: Bool = false
    var showCreateGroup: Bool = false
    var searchText: String = ""
    var isSelected: Bool = false
    var contacts: [String: [Contact]] = [
        "Frequently contacted": [
            Contact(name: "زوجة", details: nil),
            Contact(name: "Benni Indrawan Indocyber", details: "www.indocyber.co.id"),
            // Add more contacts...
        ],
        "A": [
            Contact(name: "Abishar", details: nil),
            // Add more contacts...
        ],
        // Add more sections...
    ]
}
