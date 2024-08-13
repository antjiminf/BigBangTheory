import SwiftUI

extension EpisodeDTO {
    var toPresentationTest: Episode {
        Episode(
            id: id, url: url, name: name, season: season, number: number, airdate: airdate, runtime: runtime, image: image, summary: summary, favorite: Bool.random(), viewed: Bool.random(), note: "Note testing", rating: Bool.random() ? Int.random(in: 1...5) : nil)
    }
}

struct EpisodeInteractorTest: DataInteractor, JSONInteractor {
    
    var urlDoc: URL {
        if #available(iOS 16.0, *) {
            return URL.documentsDirectory.appending(path: "BigBangTest.json")
        } else {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    }
    
    func loadEpisodes() throws -> [Episode] {
        
        if FileManager.default.fileExists(atPath: urlDoc.path()) {
            return try getFromJSON(url: urlDoc, type: [EpisodeDTO].self).map(\.toPresentationTest)
        } else {
            guard let url = Bundle.main.url(forResource: "BigBangTest", withExtension: "json") else { return [] }
            return try getFromJSON(url: url, type: [EpisodeDTO].self).map(\.toPresentationTest)
        }
    }
    
    func saveEpisodes(episodes: [Episode]) throws {
        
    }
    
}

extension ContentView {
    static var preview: some View {
        ContentView()
            .environmentObject(EpisodesVM(interactor: EpisodeInteractorTest()))
    }
}

extension EpisodeListView {
    static var preview: some View {
        EpisodeListView()
            .environmentObject(EpisodesVM(interactor: EpisodeInteractorTest()))
    }
}

extension EpisodeDetailsView {
    static var preview: some View {
        NavigationStack {
            EpisodeDetailsView(reviewVm: EpisodeReviewVM(episode: .episodeTest))
                .environmentObject(EpisodesVM(interactor: EpisodeInteractorTest()))
        }
    }
}

extension EpisodeDetails2View {
    static var preview: some View {
        NavigationStack {
            EpisodeDetails2View(reviewVm: EpisodeReviewVM(episode: .episodeTest))
                .environmentObject(EpisodesVM(interactor: EpisodeInteractorTest()))
        }
    }
}

extension EpisodeReviewForm {
    static var preview: some View {
        EpisodeReviewForm(reviewVm: EpisodeReviewVM(episode: .episodeTest))
            .environmentObject(EpisodesVM(interactor: EpisodeInteractorTest()))
    }
}

extension FavoriteGridView {
    static var preview: some View {
        FavoriteGridView()
            .environmentObject(EpisodesVM(interactor: EpisodeInteractorTest()))
    }
}
extension Episode {
    static let episodeTest = Episode(
        id: 2928,
        url: URL(string: "https://www.tvmaze.com/episodes/2928/the-big-bang-theory-1x16-the-peanut-reaction")!,
        name: "The Peanut Reaction",
        season: 1,
        number: 16,
        airdate: "2008-05-12",
        runtime: 30,
        image: "12464",
        summary: "When Penny learns that Leonard doesn't celebrate birthdays, she attempts to throw him a surprise party, but is sidetracked by Sheldon who unexpectedly gets to live out one of his greatest fantasies at an electronics store.\n",
        favorite: true,
        viewed: true,
        note: "Hello",
        rating: 4
    )
}
