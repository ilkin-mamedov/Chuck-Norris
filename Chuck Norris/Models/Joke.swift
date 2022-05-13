import Foundation

struct Joke: Codable {
    let id: String
    let url: String
    let icon_url: String
    let created_at: String
    let updated_at: String
    let value: String
    let categories: [String]
}
