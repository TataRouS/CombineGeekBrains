//
//  NewViewController.swift
//  Storyboard
//
//  Created by Nata Kuznetsova on 06.08.2023.
//

import Foundation
import Combine

class ViewModelNew: ObservableObject {
    
    var subscriptions: Set<AnyCancellable> = []
    
 @Published var apiClient: APIClient
    //@Published var episode: AnyPublisher<Episode, NetworkError>
    // @Published var location: AnyPublisher<Episode, Error>
 @Published var id: String = ""
 @Published var episodeDescription: String = ""
    
    internal init (
        apiClient: APIClient
        
    ) {
        self.apiClient = apiClient
        
        
//        let networkingForEpisode = self.$id.map {
//            apiClient.episode(id: Int($0) ?? 1)}
//            .switchToLatest()
//            .share()
//        self.episode = networkingForEpisode.eraseToAnyPublisher()
        
//        let networkingForLocation = inputIndentifiersPublisher.map {
//            apiClient.location(id: $0) }
//            .switchToLatest()
//            .share()
//        self.location = networkingForLocation.eraseToAnyPublisher()
    }
    
    func fetchEpisode (){
        let _: () = self.$id.flatMap {[weak self] episodeId in
            (self?.apiClient.episode(id: Int(episodeId) ?? 1))! }
            .map { $0.description
                print ("ViewModel\($0)")
                return $0.description
                }
            .catch { _ in Empty<String, Never>() }
            .receive(on: RunLoop.main)
            .sink(receiveValue: {[weak self] text in
                self?.episodeDescription = text
               print(text)
                
            })

          .store(in: &subscriptions)
    }
     
        
    // Do any additional setup after loading the view.
}



