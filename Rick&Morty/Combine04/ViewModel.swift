//
//  ViewModel.swift
//  Homework04
//
//  Created by Nata Kuznetsova on 08.10.2023.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
 @Published var apiClient: APIClient
 @Published var episode: AnyPublisher<Episode, NetworkError>
 @Published var location: AnyPublisher<Episode, Error>
    
    internal init (
        apiClient: APIClient,
        inputIndentifiersPublisher: AnyPublisher<Int, Never>
    ) {
        self.apiClient = apiClient
        let networkingForEpisode = inputIndentifiersPublisher.map {
            apiClient.episode(id: $0) }
            .switchToLatest()
            .share()
        self.episode = networkingForEpisode.eraseToAnyPublisher()
        
        let networkingForLocation = inputIndentifiersPublisher.map {
            apiClient.location(id: $0) }
            .switchToLatest()
            .share()
        self.location = networkingForLocation.eraseToAnyPublisher()
    }
    
    // Do any additional setup after loading the view.
}
