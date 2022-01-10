//
//  HomeView.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 09.01.2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var homeViewModel: HomeViewModel = .init()
    
    var body: some View {
        VStack {
            Button {
                homeViewModel.animeGenreService?.getAnimes()
            } label: {
                Text("Update")
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        Capsule()
                            .foregroundColor(.blue)
                    )
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(homeViewModel.animeList) {
                        anime in
                        Text(anime.title ?? "")
                    }
                }
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
