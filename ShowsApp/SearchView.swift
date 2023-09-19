//
//  SearchView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 19.09.2023..
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = SearchViewModel()
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchText)
                    .onChange(of: searchText) { word in
                        viewModel.fetchData(searchWord: word)
                    }
                Spacer()
                if(!(viewModel.shows.isEmpty)) {
                    Text("\(viewModel.shows.count)")
                    List(viewModel.shows) { show in
                        HStack {
                            AsyncImage(url: URL(string: show.image.original)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 64, height: 64)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                case .failure:
                                    Text("Failed to load image")
                                default:
                                    ProgressView()
                                }
                            }

                            Text(show.name)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {       
    static var previews: some View {
        SearchView()
    }
}
