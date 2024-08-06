//
//  WhatsappMainTabModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 04/08/24.
//

import Foundation
import SwiftUI

struct WhatsappMainTabModel<Content: View>: Identifiable {
    let id = UUID()
    let content: Content
    let title: String
    let image: String
}
