//
//  SearchBarView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 19.09.2023..
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(height: 40)
            HStack {
                Image(systemName: "magnifyingglass.circle")
                    .foregroundColor(.gray)
                    .font(.title)
                
                TextField("Search", text: $searchText)
                    .padding(.leading, 8)
                    .foregroundColor(.primary)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.horizontal, 16)
    }
}
