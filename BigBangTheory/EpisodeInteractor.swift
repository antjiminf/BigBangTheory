import Foundation

//TODO: USAR JSONINTERACTOR

struct EpisodeInteractor: JSONInteractor, DataInteractor {
    
    var urlDoc: URL {
        if #available(iOS 16.0, *) {
            return URL.documentsDirectory.appending(path: "BigBang.json")
        } else {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    }
    
    func saveEpisodes(episodes: [Episode]) throws {
        let data = try JSONEncoder().encode(episodes)
        try data.write(to: urlDoc, options: .atomic)
    }
    
    func loadEpisodes() throws -> [Episode] {
        
        if FileManager.default.fileExists(atPath: urlDoc.path()) {
            return try getFromJSON(url: urlDoc, type: [Episode].self)
        } else {
            guard let url = Bundle.main.url(forResource: "BigBang", withExtension: "json") else { return [] }
            return try getFromJSON(url: url, type: [EpisodeDTO].self).map(\.toPresentation)
        }
    }
}
