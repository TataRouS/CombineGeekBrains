//
//  NewViewController.swift
//  Storyboard
//
//  Created by Nata Kuznetsova on 06.08.2023.
//

import Foundation
import Combine

final class ViewModelNew: ObservableObject {
    
    var subscriptions: Set<AnyCancellable> = []
    
    @Published var apiClient: ApiClientProtocol
    @Published var id: String = ""
    @Published var episodeDescription: String = ""
    @Published var episodeTimer: String = ""
    
    
    internal init (
        apiClient: ApiClientProtocol
    ) {
        self.apiClient = apiClient
        
    
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
     
    func startTimer () {
        let timer = Timer.publish(every: 1, on: RunLoop.main, in: .default).autoconnect()

         timer.sink { [weak self] date in
                self?.fetchEpisodeData()
                print(date)
            }.store(in: &subscriptions)
    }
    
    func fetchEpisodeData() -> Void {
        let id = Int.random(in: 1..<51)
        let publisher = self.apiClient.episode(id: id)
            .map { $0.description
            print ("Timer data\($0)")
            return $0.description
            }
            .catch { _ in Empty<String, Never>() }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {print($0) },
                receiveValue: {[weak self] text in
                self?.episodeTimer = text
                print(text)
            })
            .store(in: &subscriptions)
    }
}



