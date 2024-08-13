import Foundation

protocol JSONInteractor {
    func getFromJSON<JSON>(url: URL, type: JSON.Type) throws -> JSON where JSON: Codable
}

extension JSONInteractor {
    func getFromJSON<JSON>(url: URL, type: JSON.Type) throws -> JSON where JSON: Codable {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(type, from: data)
    }
    
}
