//
//  Repository.swift
//  vkAPP
//
//
import Foundation
import RealmSwift

class Repository: Object, Identifiable {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var descriptionText: String?
    @Persisted var ownerAvatarUrl: String?
    
    convenience init(id: String, name: String, descriptionText: String?, ownerAvatarUrl: String?) {
        self.init()
        self.id = id
        self.name = name
        self.descriptionText = descriptionText
        self.ownerAvatarUrl = ownerAvatarUrl
    }
}
