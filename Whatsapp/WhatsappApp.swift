//
//  WhatsappApp.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/07/24.
//

import SwiftUI
import SwiftData
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct WhatsappApp: App {
    @Environment(\.modelContext) private var modelContext
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            WhatsappChatsStorage.self,
            WhatsappArchivedChatsStorage.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            WhatsappRootScreen()
                .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
    
    init(){
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
