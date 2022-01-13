//
//  NetworkingManager.swift
//  OTUSHM3
//
//  Created by Дмитрий Мальцев on 28.12.2021.
//

import Combine
import Foundation

public class NetworkingManager {
    private static var jsonDecoder = {
       JSONDecoder()
    }()
    
    public static func request<T: Codable>(url: URL, type: T.Type) -> AnyPublisher<T, Error> {
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
            .decode(type: T.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    public static func handleCompletion(completion: Subscribers.Completion<Error>) -> Void {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
