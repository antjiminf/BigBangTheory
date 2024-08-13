import Foundation

protocol DataInteractor {
    func loadEpisodes() throws -> [Episode]
    func saveEpisodes(episodes: [Episode]) throws
}
