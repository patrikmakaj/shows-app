//
//  ScrollViewItem.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 29.09.2023..
//

import SwiftUI

struct ScrollViewItem: View {
    let show: Show
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
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
                .frame(width: 150, height: 250)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("PrimaryYellow"))
                        Text(show.ratingString)
                            .foregroundColor(Color("PrimaryLightGray"))
                    }
                    Text(show.name)
                        .foregroundColor(Color("PrimaryWhite"))
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(show.name)
        }
    }
}

struct ScrollViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewItem(show: Show.example)
    }
}
