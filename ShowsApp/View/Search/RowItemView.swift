//
//  RowItemView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 20.09.2023..
//

import SwiftUI

struct RowItemView: View {
    @ObservedObject var viewModel: SearchViewModel
    let show: Show
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: show.image!.original)) { phase in
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
            .frame(width: 64, height: 64)
            .padding(.vertical)
            
            VStack(alignment: .leading) {
                Text(show.name)
                    .foregroundColor(Color("PrimaryWhite"))
                    .font(.headline)
                Group {
                    Text(show.premiereYear)
                    if let cast = viewModel.cast[show.id] {
                        Text("\(cast.prefix(2).map { $0.name }.joined(separator: ", "))")
                    }
                }
                .font(.subheadline)
                .foregroundColor(Color("PrimaryLightGray"))
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(show.name)
    }
}

struct RowItemView_Previews: PreviewProvider {
    static var previews: some View {
        RowItemView(viewModel: SearchViewModel(), show: Show.example)
    }
}
