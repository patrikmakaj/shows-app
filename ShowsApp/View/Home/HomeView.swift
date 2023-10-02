//
//  HomeView.swift
//  ShowsApp
//
//  Created by Patrik Makaj on 22.09.2023..
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Shows")
                        .font(.title2.bold())
                        .foregroundColor(Color("PrimaryLightGray"))
                    Spacer()
                    Button("Show all") {}
                        .font(.footnote)
                        .foregroundColor(Color("PrimaryYellow"))
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.shows) { show in
                            NavigationLink(destination: DetailView(viewModel: DetailViewModel(show: show))) {
                                HomeScrollViewItem(show: show)
                                    .frame(width: 180, height: 350)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 1)
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchSearchData(query: "Top")
                }
                HStack {
                    Text("Schedule")
                        .font(.title3.bold())
                        .foregroundColor(Color("PrimaryLightGray"))
                    Spacer()
                    Button("Show all") {}
                        .font(.footnote)
                        .foregroundColor(Color("PrimaryYellow"))
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.scheduleShows) { show in
                            NavigationLink(destination: DetailView(viewModel: DetailViewModel(show: show))) {
                                ScheduleScrollViewItem(show: show)
                                    .frame(width: 125, height: 230)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 1)
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchSchedule()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
