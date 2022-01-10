//
//  NetworkingManager.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 28.12.2021.
//

import Combine
import Foundation

public class NetworkingManager {
    public static func request<T: Codable, Decoder: TopLevelDecoder>(url: URL, type: T.Type, decoder: Decoder) -> Publishers.Decode<AnyPublisher<Data, Error>, T, Decoder> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap {
                output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                          throw URLError(.badURL)
                      }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .decode(type: T.self, decoder: decoder)
    }
}
