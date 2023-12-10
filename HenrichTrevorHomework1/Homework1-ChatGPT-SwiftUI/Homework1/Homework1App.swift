//
//  Homework1App.swift
//  Homework1
//
//  Created by Trevor Henrich on 9/12/23.
//

import SwiftUI

@main
struct Homework1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
