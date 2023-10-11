//
//  SwiftUIView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 11.10.2023..
//

import SwiftUI

struct FavoritesItemView: View {
    let show: Show
    @ObservedObject var viewModel: FavoritesViewModel
    let favoritesService: FavoriteServiceProtocol
    init(viewModel: FavoritesViewModel, show: Show) {
        self.viewModel = viewModel
        self.show = show
        self.favoritesService = viewModel.favoritesService
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 150, height: 200) // Adjust the size of the rounded rectangle
            ZStack {
                AsyncImage(url: URL(string: show.image?.original ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .frame(width: 150, height: 200) // Match the size of the rounded rectangle
                            .cornerRadius(5) // Apply the same corner radius as the RoundedRectangle
                    case .failure:
                        Image(systemName: "questionmark")
                            .font(.largeTitle)
                            .foregroundColor(Color("PrimaryLightGray"))
                    default:
                        ProgressView()
                    }
                }
                .frame(width: 150, height: 200) // Match the size of the rounded rectangle
            }
            VStack {
                HStack {
                    Button(action: {
                        _ = favoritesService.toggleFavorite(show: show)
                    }) {
                        Image(systemName: "heart.fill")
                            .padding(10)
                            .foregroundColor(favoritesService.isfavorite(show: show) ? Color("PrimaryYellow") : Color("PrimaryLightGray"))
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("PrimaryBlack")))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .border(Color("PrimaryLightGray"), width: 1)
                    Spacer()
                }
                .padding(.top, 15)
                Spacer()
            }
            .alignmentGuide(.top) { _ in 0 }
            .alignmentGuide(.leading) { _ in 0 }
        }
    }
}


struct FavoritesItemView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesItemView(viewModel: FavoritesViewModel(favoritesService: FavoriteService(persistenceService: PersistenceService())), show: Show.example)
    }
}
