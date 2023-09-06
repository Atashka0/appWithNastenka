//
//  AppWithNastenkaApp.swift
//  AppWithNastenka
//
//  Created by Ilyas Kudaibergenov on 07.09.2023.
//

import SwiftUI

@main
struct AppWithNastenkaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
