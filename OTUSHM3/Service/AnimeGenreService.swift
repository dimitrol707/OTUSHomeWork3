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
    
    public func getAnimes(genre: GenreAnime = .action, page: Int = 1) -> AnyPublisher<[Anime], Error> {
        guard let url = URL(string: "https://api.jikan.moe/v3/genre/anime/\(genre.rawValue)/\(page)")
            else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
        
        return NetworkingManager.request(url: url, type: Genre.self)
            .compactMap({ genre in
                return genre.anime!
            })
            .eraseToAnyPublisher()
    }
}
