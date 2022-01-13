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
    
    init() {
        getAnimes()
    }
    
    public func refreshAnimes() {
        guard let genreService  = animeGenreService else { return }
        genreService.getAnimes()
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {
                [weak self] animes in
                guard let self = self else { return }
                self.animeList = animes
                if let dataService = self.animeDataService {
                    animes.forEach {
                        anime in
                        dataService.updateEntity(anime: anime)
                    }
                }
            })
            .cancel()
    }
    
    public func getAnimes() {
        guard let service  = animeDataService else { return }
        let savedEntities = service.fetchAnime()
        if savedEntities.isEmpty {
            refreshAnimes()
        } else {
            self.animeList = savedEntities
        }
    }
}
