//
//  ContentView.swift
//  Newsly
//
//  Created by Trevor Henrich on 12/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // Tab Navigation
            TabView{
                Home().tabItem {Image(systemName: "house")}
                Search().tabItem {Image(systemName: "magnifyingglass")}
                Categories().tabItem{Image(systemName: "slider.horizontal.3")}
                Bookmarks().tabItem {Image(systemName: "bookmark")}
            }
        }
    }
}

#Preview {
    ContentView()
}
