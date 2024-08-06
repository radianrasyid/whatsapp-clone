//
//  WhatsappUpdatesItemModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 04/08/24.
//

import Foundation
import SwiftUI

struct WhatsappUpdatesItemModel: Identifiable {
    let id = UUID()
    let name: String
    let updatedAt: String
    let image: String
    var viewed: Bool
}
