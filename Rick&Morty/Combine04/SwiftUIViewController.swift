//
//  SwiftUIViewController.swift
//  Homework04
//
//  Created by Nata Kuznetsova on 06.10.2023.
//

import SwiftUI
import Combine


struct SwiftUIViewController: View {
    
    //   @State var viewModelNew.id = ""
    
    @ObservedObject private var viewModelNew = ViewModelNew(apiClient: APIClient())
    private var subscriptions: Set<AnyCancellable> = []
    
    //    @Strate   private let episodeObservable = EpisodeObservable(episode: " ")
    
    //@State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //
    //    @State  var inputNumber = inputTextField.publisher(for: \.text).compactMap{ $0.flatMap(Int.init) }.eraseToAnyPublisher()
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 30){
            
            Text("Рик и Морти")
                .padding(.top, 20)
                .font(.largeTitle)
                .foregroundColor(.blue)
            Text("Информация об эпизоде")
                .foregroundColor(.blue)
            TextField("Введите id Эпизода", text: $viewModelNew.id)
            Text("Эпизод \(viewModelNew.episodeDescription)")
                .foregroundColor(.blue)
                  Spacer()
                      .frame(height: 500)
                  Text("Timer\(viewModelNew.episodeTimer)")
                .onAppear(){
                    viewModelNew.fetchEpisode()
                    viewModelNew.startTimer()
                    print("onAppear")
                }
        }
    }
    
    struct SwiftUIViewController_Previews: PreviewProvider {
        static var previews: some View {
            SwiftUIViewController()
        }
    }
}
