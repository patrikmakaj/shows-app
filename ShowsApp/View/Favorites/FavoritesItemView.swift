//
//  SwiftUIView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 11.10.2023..
//

import SwiftUI

struct FavoritesItemView: View {
    let favoriteService: FavoriteServiceProtocol
    let show: Show
    @State private var isFavorite: Bool
    let onToggleFavorite: () -> Void

    init(favoriteService: FavoriteServiceProtocol, show: Show, onToggleFavorite: @escaping () -> Void) {
        self.favoriteService = favoriteService
        self.show = show
        self._isFavorite = State(initialValue: favoriteService.isfavorite(show: show))
        self.onToggleFavorite = onToggleFavorite
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 150, height: 200)
            ZStack {
                AsyncImage(url: URL(string: show.image?.original ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .frame(width: 150, height: 200)
                            .cornerRadius(5)
                    case .failure:
                        Image(systemName: "questionmark")
                            .font(.largeTitle)
                            .foregroundColor(Color("PrimaryLightGray"))
                    default:
                        ProgressView()
                    }
                }
                .frame(width: 150, height: 200)
            }
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            _ = favoriteService.toggleFavorite(show: show)
                            isFavorite.toggle()
                            onToggleFavorite()
                       }
                    } label: {
                        Image(systemName: "heart.fill")
                            .padding(10)
                            .foregroundColor(isFavorite ? Color("PrimaryYellow") : Color("PrimaryLightGray"))
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
        .onAppear() {
            isFavorite = favoriteService.isfavorite(show: show)
        }
    }
}
