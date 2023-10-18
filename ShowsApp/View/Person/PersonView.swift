//
//  PersonView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 17.10.2023..
//

import SwiftUI

struct PersonView: View {
    let person: Person
    
    var body: some View {
        ZStack {
            Color("PrimaryBlack")
            VStack {
                AsyncImage(url: URL(string: person.image.original)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .edgesIgnoringSafeArea(.all)
                    case .failure:
                        Image(systemName: "questionmark")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(Color("PrimaryLightGray"))
                    default:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(person.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("Country: \(person.country.name)")
                            .font(.headline)
                            .foregroundColor(.white)
                        AsyncImage(url: person.countryUrl) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: 32, maxHeight: 32)
                                    .edgesIgnoringSafeArea(.all)
                            case .failure:
                                Image(systemName: "questionmark")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .foregroundColor(Color("PrimaryLightGray"))
                            default:
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                    }
                    
                    Text("Birthday: \(person.birthday ?? "Unknown")")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Gender: \(person.gender)")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

