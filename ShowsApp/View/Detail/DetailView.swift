//
//  DetailView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 02.10.2023..
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
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
                
                Text(viewModel.show.formattedSummary)
                    .font(.body)
                    .foregroundColor(Color("PrimaryLightGray"))
                    .padding(.trailing, 10)
                
                HStack {
                    Text("Cast")
                        .font(.title3.bold())
                        .foregroundColor(Color("PrimaryLightGray"))
                    Spacer()
                    Button("Show all") {}
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
        }

        .edgesIgnoringSafeArea(.top)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(show: Show.example))
    }
}
