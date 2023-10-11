//
//  FavoritesView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 22.09.2023..
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(viewModel.favorites) { show in
                    VStack {
                        FavoritesItemView(viewModel: viewModel, show: show)
                            .onTapGesture {
                                viewModel.onShowTapped?(show)
                            }
                    }
                    .frame(height: 210)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.refresh()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: FavoritesViewModel(favoritesService: FavoriteService(persistenceService: PersistenceService())))
    }
}
