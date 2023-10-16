//
//  ScheduleScrollViewItem.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 02.10.2023..
//

import SwiftUI

struct ScheduleScrollViewItem: View {
    let favoriteService: FavoriteServiceProtocol
    let show: Show
    @State private var isFavorite: Bool

    init(favoriteService: FavoriteServiceProtocol, show: Show) {
        self.favoriteService = favoriteService
        self.show = show
        _isFavorite = State(initialValue: favoriteService.isfavorite(show: show))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                AsyncImage(url: URL(string: show.image?.original ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .frame(width: 125, height: 60)
                            .padding(.bottom, 15)
                    case .failure:
                        Image(systemName: "questionmark")
                            .font(.largeTitle)
                            .foregroundColor(Color("PrimaryLightGray"))
                    default:
                        ProgressView()
                    }
                }
                
                VStack {
                    HStack {
                        Button {
                            withAnimation {
                                favoriteService.toggleFavorite(show: show)
                                isFavorite.toggle()
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
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                Text("\(show.schedule.time)")
                    .font(.caption)
                    .foregroundColor(Color("PrimaryLightGray"))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.leading, 2)
                Text(show.name)
                    .font(.caption2)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(Color("PrimaryWhite"))
                    .padding(.leading, 2)
            }
            .padding(.bottom, 5)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(show.name)
        .onAppear() {
            isFavorite = favoriteService.isfavorite(show: show)
        }
    }
}

struct ScheduleScrollViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleScrollViewItem(favoriteService: FavoriteService(persistenceService: PersistenceService()), show: Show.example)
    }
}

