//
//  Item.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/07/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
