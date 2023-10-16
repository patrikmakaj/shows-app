//
//  ShowAllView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 12.10.2023..
//

import SwiftUI
struct ShowAllView: View {
    @ObservedObject var viewModel: ShowAllViewModel
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(viewModel.allShows) { show in
                    VStack {
                        FavoritesItemView(favoriteService: viewModel.favoritesService, show: show) {
                        }
                        .onTapGesture {
                            viewModel.onShowTapped?(show)
                        }
                    }
                    .frame(height: 210)
                }
            }
            .padding()
        }
    }
}

struct ShowAllView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllView(viewModel: ShowAllViewModel(allShows: [Show.example], favoritesService: ServiceFactory().favoriteService))
    }
}
