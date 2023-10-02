//
//  ScheduleScrollViewItem.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 02.10.2023..
//

import SwiftUI

struct ScheduleScrollViewItem: View {
    let show: Show
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
                        Button(action: {
                            // Handle favorite action
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
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(show.schedule.time)")
                    .font(.caption)
                    .foregroundColor(Color("PrimaryLightGray"))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.leading, 15)
                Text(show.name)
                    .font(.callout)
                    .foregroundColor(Color("PrimaryWhite"))
                    .padding(.leading, 15)
            }
            .padding(.bottom, 5)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(show.name)
    }
}

struct ScheduleScrollViewItem_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleScrollViewItem(show: Show.example)
    }
}
