//
//  SearchView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 19.09.2023..
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color("PrimaryDarkGray")
                    .ignoresSafeArea()
                VStack {
                    SearchBarView(searchText: $viewModel.searchWord)
                        .onChange(of: viewModel.searchWord) { word in
                            viewModel.fetchSearchData(query: word)
                        }
                        .accessibilityLabel("Search for \(viewModel.searchWord)")
                    Spacer()
                    if(!(viewModel.shows.isEmpty)) {
                        List(viewModel.shows) { show in
                            RowItemView(viewModel: viewModel, show: show)
                                .listRowBackground(Color("PrimaryBlack"))
                                .onTapGesture {
                                    viewModel.onShowTapped?(show)
                                }
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
