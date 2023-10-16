//
//  EpisodeViewModelMock.swift
//  Homework04Tests
//
//  Created by Nata Kuznetsova on 12.10.2023.
//

import Foundation
import Combine
@testable import Homework04

final class APIClientMock: ApiClientProtocol {
    
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)
    
   var episode1 = Episode(id: 32, name: "Edge of Tomorty: Rick, Die, Rickpeat", air_date: "November 10, 2019", episode: "S04E01", created: "2020-04-30T06:52:04.495Z")
   private var episode2 = Episode(id: 25, name: "Vindicators 3: The Return of Worldender", air_date: "August 13, 2017", episode: "S03E04", created: "2017-11-10T12:56:36.310Z")
    private var arrayEpisode: [Episode] = []
    
    func episode(id: Int) -> AnyPublisher<Episode, NetworkError> {
        arrayEpisode.append(episode1)
        return arrayEpisode.publisher
            .receive(on: queue)
            .mapError({error -> NetworkError in
                    return NetworkError.invalidResponse
            })
        .eraseToAnyPublisher()
    }
    
    func location(id: Int) -> AnyPublisher<Episode, Error>{
      return Empty<Episode, Error>()
            .eraseToAnyPublisher()
    }
    
    init(){}
}
