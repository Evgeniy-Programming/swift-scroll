//
//  RepositoryRowView.swift
//  vkAPP
//
//

import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository
    
    var body: some View {
        HStack {
            if let urlString = repository.ownerAvatarUrl, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView() // Индикатор загрузки
                        .frame(width: 50, height: 50)
                }
            }
            VStack(alignment: .leading) {
                Text(repository.name)
                    .font(.headline)
                Text(repository.descriptionText ?? "No description")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
