import SwiftUI

@main
struct BigBangTheoryApp: App {
    @StateObject var episodesVM = EpisodesVM()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(episodesVM)
        }
    }
}
