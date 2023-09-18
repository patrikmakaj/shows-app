//
//  ContentView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 18.09.2023..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Shows app")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
