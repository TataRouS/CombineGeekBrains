//
//  ApiClient.swift
//  Homework04
//
//  Created by Nata Kuznetsova on 28.09.2023.
//

import Foundation
import Combine

struct APIClient {
    
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)
    
 
//MARK: В функции закомментирована часть кода по дз№4 задание на отладку части кода. 
    
    
    func episode(id: Int) -> AnyPublisher<Episode, NetworkError> {
    URLSession.shared
        .dataTaskPublisher(for: Method.episode(id).url)
        .receive(on: queue)
        .map(\.data)
        .decode(type: Episode.self, decoder: decoder)
//        .breakpoint(receiveOutput: { episode in
//            return episode.id == 7
//        })
    //.catch { _ in Empty<Episode, Error>() }
        .mapError({error -> NetworkError in
            switch error {
            case is URLError:
                return NetworkError.unreachableAddress(url: Method.episode(id).url)
            default:
                return NetworkError.invalidResponse
                
            }
        })
        .eraseToAnyPublisher()
}
    
    func mergedEpisods(ids: [Int]) -> AnyPublisher<Episode, NetworkError> {
        precondition(!ids.isEmpty)
        
        let initialPublisher = episode(id: ids[0])
        let remainder = Array(ids.dropFirst())
        
        return remainder.reduce(initialPublisher) { (combined, id) in
            return combined
                .merge(with: episode(id: id))
                .eraseToAnyPublisher()
        }
    }
}
