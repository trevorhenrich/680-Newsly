//
//  NewslyApp.swift
//  Newsly
//
//  Created by Trevor Henrich on 12/6/23.
//

import SwiftUI

@main
struct NewslyApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
