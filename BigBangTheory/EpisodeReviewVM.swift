import SwiftUI

final class EpisodeReviewVM: ObservableObject {
    
    @Published var episode: Episode
    
    @Published var favorited = false {
        didSet {
            checkForChanges()
        }
    }
    @Published var viewed = false {
        didSet {
            checkForChanges()
        }
    }
    @Published var note = "" {
        didSet {
            checkForChanges()
        }
    }
    @Published var rating = 0 {
        didSet {
            checkForChanges()
        }
    }
    @Published var changed = false
    
    init(episode: Episode) {
        self.episode = episode
        initEpisode(episode: episode)
    }
    
    func initEpisode(episode: Episode) {
        self.favorited = episode.favorite
        self.viewed = episode.viewed
        self.note = episode.note
        self.rating = episode.rating ?? 0
        self.changed = false
    }
    
    func updateEpisode() -> Episode {
        episode = Episode(id: episode.id,
                url: episode.url,
                name: episode.name,
                season: episode.season,
                number: episode.number,
                airdate: episode.airdate,
                runtime: episode.runtime,
                image: episode.image,
                summary: episode.summary,
                favorite: favorited,
                viewed: viewed,
                note: note,
                rating: rating)
        changed = false
        return episode
    }
    
    func cancelChanges() {
        initEpisode(episode: self.episode)
    }
    
    private func checkForChanges() {
        changed = (favorited != episode.favorite ||
                      viewed != episode.viewed ||
                      note != episode.note ||
                      rating != (episode.rating ?? 0))
    }
}


