//
//  WhatsappCallsViewModel.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/08/24.
//

import Foundation
import SwiftUI

@Observable class WhatsappCallsViewModel {
    var searchValue: String = ""
    var createLinkSheet: Bool = false
    var callType = "Video"
    var showDetail: Bool = false
    var listId: String = "0" {
        didSet{
            showDetail = true
        }
    }
    var selectedTab: WhatsappCallsTab = .all
}
