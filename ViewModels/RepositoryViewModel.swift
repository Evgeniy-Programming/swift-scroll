//
//  RepositoryViewModel.swift
//  vkAPP
//
//

import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    private var currentPage = 1
    private var canLoadMore = true
    private var cancellables = Set<AnyCancellable>()
    private let api = GitHubAPI()
    private let realmService = RealmService() // Создание экземпляро RealmService
    
    func loadMore() {
        guard canLoadMore else { return }
        
        Task {
            do {
                let newRepositories = try await api.fetchRepositories(page: currentPage)
                repositories.append(contentsOf: newRepositories)
                
                // Сохранение загруженных репозиториев в Realm
                for repo in newRepositories {
                    realmService.save(repository: repo)
                }
                
                currentPage += 1
                canLoadMore = !newRepositories.isEmpty
            } catch {
                print(error)
            }
        }
    }
    
    func deleteRepository(at offsets: IndexSet) {
        let repositoriesToDelete = offsets.map { repositories[$0] }
        for repository in repositoriesToDelete {
            realmService.delete(repository: repository) // Удаление из Realm
        }
        repositories.remove(atOffsets: offsets) // Удаление из массива
    }
}
