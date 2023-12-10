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
                Home().tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                Search().tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                Categories().tabItem{
                    Image(systemName: "slider.horizontal.3")
                    Text("Categories")
                }
                Bookmarks().tabItem {
                    Image(systemName: "bookmark")
                    Text("Bookmarks")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
