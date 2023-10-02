//
//  HomeScrollViewItem.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 29.09.2023..
//

import SwiftUI

struct HomeScrollViewItem: View {
    let show: Show
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
                            Button(action: {
                            }) {
                                Image(systemName: "heart.fill")
                                    .padding(10)
                                    .foregroundColor(Color("PrimaryYellow"))
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
        }
    }

}

struct HomeScrollViewItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeScrollViewItem(show: Show.example)
    }
}
