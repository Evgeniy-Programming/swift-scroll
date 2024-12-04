//
//  GitHubAPI.swift
//  vkAPP
//
//

import Foundation

class GitHubAPI {
    private let baseURL = "https://api.github.com/search/repositories"
    
    func fetchRepositories(page: Int) async throws -> [Repository] {
        let url = URL(string: "\(baseURL)?q=swift&sort=stars&order=asc&page=\(page)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(GitHubResponse.self, from: data)
        return response.items.map {
            Repository(id: $0.id, name: $0.name, descriptionText: $0.descriptionText, ownerAvatarUrl: $0.owner.avatarUrl)
        }
    }
}

struct GitHubResponse: Codable {
    let items: [GitHubRepo]
}

struct GitHubRepo: Codable {
    let id: String
    let name: String
    let descriptionText: String?
    let owner: Owner
    
    struct Owner: Codable {
        let avatarUrl: String
        
        enum CodingKeys: String, CodingKey {
            case avatarUrl = "avatar_url"
        }
    }
}
