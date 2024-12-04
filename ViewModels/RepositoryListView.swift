//
//  RepositoryListView.swift
//  vkAPP
//
//

import SwiftUI

struct RepositoryListView: View {
    @StateObject private var viewModel = RepositoryViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repositories) { repo in
                    RepositoryRowView(repository: repo)
                        .onAppear {
                            if repo == viewModel.repositories.last {
                                viewModel.loadMore()
                            }
                        }
                }
                .onDelete(perform: viewModel.deleteRepository)
            }
            .onAppear {
                viewModel.loadMore()
            }
            .navigationTitle("Repositories")
        }
    }
}
