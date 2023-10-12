//
//  HomeScrollViewItem.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 29.09.2023..
//

import SwiftUI

struct HomeScrollViewItem: View {
    let favoriteService: FavoriteServiceProtocol
    let show: Show
    @State private var isFavorite: Bool

    init(favoriteService: FavoriteServiceProtocol, show: Show) {
        self.favoriteService = favoriteService
        self.show = show
        _isFavorite = State(initialValue: favoriteService.isfavorite(show: show))
    }
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                ZStack {
                    AsyncImage(url: URL(string: show.image?.original ?? "")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                                .frame(width: 180, height: 300)
                        case .failure:
                            Image(systemName: "questionmark")
                                .font(.largeTitle)
                                .foregroundColor(Color("PrimaryLightGray"))
                        default:
                            ProgressView()
                        }
                    }
                    .frame(width: 180, height: 300)
                    VStack {
                        HStack {
                            Button {
                                withAnimation {
                                    _ = favoriteService.toggleFavorite(show: show)
                                    isFavorite.toggle()
                               }
                            } label: {
                                Image(systemName: "heart.fill")
                                    .padding(10)
                                    .foregroundColor(isFavorite ? Color("PrimaryYellow") : Color("PrimaryLightGray"))
                                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("PrimaryBlack")))
                                    .scaleEffect(isFavorite ? 1.1 : 1.0)
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
                Spacer()
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("PrimaryYellow"))
                        Text(show.ratingString)
                            .foregroundColor(Color("PrimaryLightGray"))
                            .font(.headline)
                    }
                    Spacer()
                    Text(show.name)
                        .foregroundColor(Color("PrimaryWhite"))
                }
                .padding([.leading, .bottom], 15)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(show.name)
            .onAppear() {
                isFavorite = favoriteService.isfavorite(show: show)
            }
        }
    }

}

struct HomeScrollViewItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeScrollViewItem(favoriteService: FavoriteService(persistenceService: PersistenceService()), show: Show.example)
    }
}
