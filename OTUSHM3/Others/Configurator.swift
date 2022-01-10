//
//  Configurator.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 09.01.2022.
//

import Foundation
import ServicePackage

class Configurator {
    static let shared = Configurator()
    
    func register() {
        ServiceLocator.shared.addServices(service: AnimeGenreService())
        ServiceLocator.shared.addServices(service: AnimeDataService())
    }
}
