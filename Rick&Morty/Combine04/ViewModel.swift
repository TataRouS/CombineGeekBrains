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


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

