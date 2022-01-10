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
    
    public func updateEntity(anime: Anime) {
        if let entity = dataService.savedEntities.first(where: { $0.id == anime.id! }) {
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
