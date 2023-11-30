import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // Tab Navigation
            TabView{
                Home().tabItem {Image(systemName: "house")}
                Local().tabItem {Image(systemName: "location")}
                Bookmark().tabItem {Image(systemName: "bookmark")}
                Settings().tabItem {Image(systemName: "person")}
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


