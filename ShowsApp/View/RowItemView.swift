//
//  RowItemView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 20.09.2023..
//

import SwiftUI

struct RowItemView: View {
    let show: Show
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: show.image.original)) { phase in
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
                Group {
                    Text(show.premiereYear)
                    Text(show.genres.joined(separator: ", "))
                }
                .foregroundColor(Color("PrimaryLightGray"))
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(show.name)
    }
}

struct RowItemView_Previews: PreviewProvider {
    static var previews: some View {
        RowItemView(show: Show.example)
    }
}
