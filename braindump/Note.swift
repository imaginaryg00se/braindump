import Foundation
import SwiftData

@Model
final class Note {
    var text: String
    var createdAt: Date

    init(text: String, createdAt: Date = Date()) {
        self.text = text
        self.createdAt = createdAt
    }
}
