//
//  AnimeDataService.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 09.01.2022.
//

import CoreData
import ServicePackage

class AnimeDataService {
    private let containerName: String = "AnimeContainer"
    private let entityName: String = "AnimeEntity"
    
    public let dataService: DataService<AnimeEntity>
    
    init() {
        dataService = .init(containerName: containerName, entityName: entityName)
    }
    
    public func fetchAnime() -> [Anime] {
        let savedEntities = dataService.fetch()
        return savedEntities
                    .compactMap { anime -> Anime? in
                        return Anime(id: Int(anime.id), title: anime.title)
                    }
    }
    
    public func updateEntity(anime: Anime) {
        let savedEntities = dataService.fetch()
        if let entity = savedEntities.first(where: { $0.id == anime.id! }) {
            dataService.update(entity: entity, operation: {
                animeEntity in
                animeEntity.title = anime.title!
            })
        } else {
            dataService.add(operation: {
                animeEntity in
                animeEntity.id = Int32(anime.id!)
                animeEntity.title = anime.title!
            })
        }
    }
}
