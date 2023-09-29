//
//  HomeView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 22.09.2023..
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            ForEach(viewModel.shows) { show in
                                ScrollViewItem(show: show)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                    .padding(.vertical, 5)
                            }
                        }
                        .padding()
                    }
                }
                .onAppear {
                    viewModel.fetchSearchData(query: "Top") // Fetch data when the view appearsr
                }
                Text("SCHEDULE PLACEHOLDER")
            }
        }
        .navigationTitle("Shows")
        
    }
}


struct ItemView: View {
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
