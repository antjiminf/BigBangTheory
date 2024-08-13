import Foundation

struct Episode: Codable, Identifiable, Hashable {
    let id: Int
    let url: URL
    let name: String
    let season, number: Int
    let airdate: String
    let runtime: Int
    let image: String
    let summary: String
    var favorite: Bool
    var viewed: Bool
    var note: String
    var rating: Int?
    
}
