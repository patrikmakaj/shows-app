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
            ZStack {
                Color("PrimaryDarkGray")
                    .ignoresSafeArea()
                VStack {
                    SearchBarView(searchText: $searchText)
                        .onChange(of: searchText) { word in
                            viewModel.fetchData(searchWord: word)
                        }
                        .accessibilityLabel("Search for \(searchText)")
                    Spacer()
                    if(!(viewModel.shows.isEmpty)) {
                        List(viewModel.shows) { show in
                            RowItemView(show: show)
                                .listRowBackground(Color("PrimaryBlack"))
                        }
                        .listStyle(.plain)
                    }
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
