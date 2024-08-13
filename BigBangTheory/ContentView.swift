import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EpisodeListView()
                .tabItem {
                    Label("Episodes", systemImage: "display")
                }
            FavoriteGridView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
    }
}


#Preview {
    ContentView.preview
}
