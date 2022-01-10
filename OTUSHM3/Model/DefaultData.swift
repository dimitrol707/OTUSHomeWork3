//
//  DefaultData.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 28.12.2021.
//

struct DefaultData: Codable, Hashable {
    let id: Int?
    let type: String?
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case type, name, url
    }
}
