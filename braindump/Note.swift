import Foundation

struct Note: Identifiable, Codable, Hashable {
    let id: UUID
    var text: String
    let createdAt: Date
}
