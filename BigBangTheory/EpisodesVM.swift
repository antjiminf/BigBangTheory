import Foundation

final class EpisodesVM: ObservableObject {
    
    private let interactor: DataInteractor
    
    @Published var episodes: [Episode] {
        didSet {
            saveEpisodes()
        }
    }
    @Published var search = ""
    
    var filteredEpisodes: [Episode] {
        episodes.filter { e in
            if search.isEmpty {
                true
            } else {
                e.name.localizedStandardContains(search)
            }
        }
    }
    
    var organizedEpisodes: [Int: [Episode]] {
        Dictionary(grouping: filteredEpisodes, by: { $0.season })
    }
    
    var favorites: [Episode] {
        episodes.filter {$0.favorite}
    }
    
    init(interactor: DataInteractor = EpisodeInteractor()) {
        self.interactor = interactor
        do {
            episodes = try interactor.loadEpisodes()
        } catch {
            episodes = []
        }
    }
    
    func updateEpisode(episode: Episode) {
        if let i = episodes.firstIndex(where: { $0.id == episode.id }) {
            episodes[i] = episode
        }
    }
    
    func saveEpisodes() {
        do {
            try interactor.saveEpisodes(episodes: episodes)
        } catch {
            print("Episodes could not be saved: \(error.localizedDescription)")
        }
    }
    
    func watchSeason(season: Int) {
        for i in episodes.indices where episodes[i].season == season && !episodes[i].viewed {
            episodes[i].viewed.toggle()
        }
    }
    
}
