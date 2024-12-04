//
//  RealmService.swift
//  vkAPP
//
//

import Foundation
import RealmSwift

class RealmService {
    private var realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    // Сохранение репозитория в Realm
    func save(repository: Repository) {
        do {
            try realm.write {
                realm.add(repository, update: .modified) // тут происходит обновление, если объект уже существует
            }
        } catch {
            print("Ошибка при сохранении репозитория в Realm: \(error)")
        }
    }
    
    // Получение всех репозиториев из Realm
    func getAllRepositories() -> [Repository] {
        let repositories = realm.objects(Repository.self)
        return Array(repositories)
    }
    
    // Удаление репозитория из Realm
    func delete(repository: Repository) {
        do {
            try realm.write {
                realm.delete(repository)
            }
        } catch {
            print("Ошибка при удалении репозитория из Realm: \(error)")
        }
    }
}
