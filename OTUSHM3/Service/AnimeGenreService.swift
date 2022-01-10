//
//  AnimeGenreService.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 28.12.2021.
//

import SwiftUI
import Combine
import ServicePackage

class AnimeGenreService {
    @Published var animeList: [Anime]?
    private var subscriptions: AnyCancellable?
    
    public func getAnimes(genre: GenreAnime = .action, page: Int = 1) {
        guard let url = URL(string: "https://api.jikan.moe/v3/genre/anime/\(genre.rawValue)/\(page)") else { return }
        subscriptions = NetworkingManager.request(url: url, type: Genre.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: {
                [weak self] genre in
                guard let self = self else { return }
                self.animeList = genre.anime ?? []
                self.subscriptions?.cancel()
            })
    }
}
