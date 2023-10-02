//
//  DetailView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 02.10.2023..
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    var body: some View {
        Text("DETAIL VIEW OF: \(viewModel.show.name)")
            .font(.largeTitle.bold())
            .foregroundColor(.red)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(show: Show.example))
    }
}
