//
//  DetailView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 02.10.2023..
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    let favoriteService: FavoriteServiceProtocol
    @State private var isFavorite: Bool
    @State var showAllCastPresented = false
    init(viewModel: DetailViewModel, favoriteService: FavoriteServiceProtocol) {
        self.viewModel = viewModel
        self.favoriteService = favoriteService
        _isFavorite = State(initialValue: favoriteService.isfavorite(show: viewModel.show))
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 150, height: 200)
                    ZStack {
                        AsyncImage(url: URL(string: viewModel.show.image?.original ?? "")) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            case .failure:
                                Image(systemName: "questionmark")
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .font(.largeTitle)
                                    .foregroundColor(Color("PrimaryLightGray"))
                            default:
                                ProgressView()
                            }
                        }
                    }
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                _ = viewModel.favoriteService.toggleFavorite(show: viewModel.show)
                                isFavorite.toggle()
                            } label: {
                                Image(systemName: "heart.fill")
                                    .padding(10)
                                    .foregroundColor(isFavorite ? Color("PrimaryYellow") : Color("PrimaryLightGray"))
                                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("PrimaryBlack")))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .border(Color("PrimaryLightGray"), width: 1)
                        }
                        .padding(.top,100)
                        Spacer()
                    }
                }
                Spacer()
            }
            
            Text(viewModel.show.formattedSummary)
                .font(.body)
                .foregroundColor(Color("PrimaryLightGray"))
                .padding(.trailing, 10)
            
            HStack {
                Text("Cast")
                    .font(.title3.bold())
                    .foregroundColor(Color("PrimaryLightGray"))
                Spacer()
                Button("Show all") {
                    showAllCastPresented.toggle()
                }
                .sheet(isPresented: $showAllCastPresented, content: {
                    CastView(viewModel: CastViewModel(cast: viewModel.cast))
                })
                    .font(.footnote)
                    .foregroundColor(Color("PrimaryYellow"))
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(viewModel.cast.values), id: \.0.id) { person, character in
                        VStack {
                            AsyncImage(url: URL(string: person.image.original)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                case .failure:
                                    Image(systemName: "questionmark")
                                        .scaledToFill()
                                        .frame(width: 64, height: 64)
                                        .font(.largeTitle)
                                        .foregroundColor(Color("PrimaryLightGray"))
                                default:
                                    ProgressView()
                                }
                                Text(person.name)
                                    .font(.caption)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .multilineTextAlignment(.center)
                                if let character = character {
                                    Text(character.name)
                                        .font(.caption2)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .foregroundColor(Color("PrimaryLightGray"))
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .frame(width: 120)
                        }
                    }
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}
