//
//  HomeView.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 09.01.2022.
//

import SwiftUI
import UIComponents

struct HomeView: View {
    @ObservedObject private var homeViewModel: HomeViewModel = .init()
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray4)
                .ignoresSafeArea()
            VStack(spacing: 15) {
                Button {
                    homeViewModel.refreshAnimes()
                } label: {
                    Text("Update")
                }
                .buttonStyle(CustomButtonStyle())
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(homeViewModel.animeList) {
                            anime in
                            ElementView(text: anime.title ?? "")
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
