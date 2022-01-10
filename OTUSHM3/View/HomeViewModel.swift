//
//  HomeViewModel.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 09.01.2022.
//

import SwiftUI
import Combine
import ServicePackage

class HomeViewModel: ObservableObject {
    @Injected var animeGenreService: AnimeGenreService?
    @Injected var animeDataService: AnimeDataService?
    
    @Published var animeList: [Anime] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubsribers()
    }
    
    private func addSubsribers() {
        animeDataService?.dataService.$savedEntities
            .map({
                animes -> [Anime] in
                return animes
                    .compactMap { anime -> Anime? in
                        return Anime(id: Int(anime.id), title: anime.title)
                    }
            })
            .sink(receiveValue: {
                [weak self] animes in
                guard let self = self else { return }
                if animes.isEmpty {
                    self.animeGenreService?.getAnimes()
                } else {
                    self.animeList = animes
                }
            })
            .store(in: &cancellables)
        
        animeGenreService?.$animeList
            .sink(receiveValue: {
                [weak self] animes in
                guard let self = self,
                      let animes = animes else { return }
                animes.forEach {
                    anime in
                    self.animeDataService?.updateEntity(anime: anime)
                }
                self.animeList = animes
            })
            .store(in: &cancellables)
    }
}
