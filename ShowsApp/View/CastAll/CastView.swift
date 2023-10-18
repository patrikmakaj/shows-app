//
//  CastView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 16.10.2023..
//
import SwiftUI

struct CastView: View {
    @ObservedObject var viewModel: CastViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color("PrimaryBlack")
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(Array(viewModel.cast.values), id: \.0.id) { person, character in
                            NavigationLink(destination: PersonView(person: person)) {
                                VStack {
                                    AsyncImage(url: URL(string: person.image.original)) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 128, height: 128)
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
                    .padding(.top, 40)
                }
            }
        }
    }
}
