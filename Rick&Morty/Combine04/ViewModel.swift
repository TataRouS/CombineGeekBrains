//
//  NewViewController.swift
//  Storyboard
//
//  Created by Nata Kuznetsova on 06.08.2023.
//

import Foundation
import Combine

class ViewModel {
    let apiClient: APIClient
    let episode: AnyPublisher<Episode, NetworkError>
    
    internal init (
        apiClient: APIClient,
        inputIndentifiersPublisher: AnyPublisher<Int, Never>
    ) {
        self.apiClient = apiClient
        let networking = inputIndentifiersPublisher.map {
            apiClient.episode(id: $0) }
            .switchToLatest()
            .share()
        self.episode = networking.eraseToAnyPublisher()
    }
    
    // Do any additional setup after loading the view.
}



