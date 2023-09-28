//
//  FavoritesView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 22.09.2023..
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    var body: some View {
        Text("Favorites view")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: FavoritesViewModel())
    }
}
