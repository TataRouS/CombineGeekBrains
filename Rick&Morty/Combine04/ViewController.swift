//
//  ViewController.swift
//  Storyboard
//
//  Created by Nata Kuznetsova on 03.08.2023.
//

import UIKit
import Combine


class ViewController: UIViewController {
    
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    var subscriptions: Set<AnyCancellable> = []
    private var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let inputNumber = inputTextField.publisher(for: \.text).compactMap{ $0.flatMap(Int.init) }.eraseToAnyPublisher()
        
        viewModel = ViewModel(
            apiClient: APIClient(), inputIndentifiersPublisher: inputNumber)
        
        viewModel?.episode
            .map { $0.description }
            .catch { _ in Empty<String, Never>() }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {print($0) },
                  receiveValue: {[weak self] text in
                self?.textLabel.text = text
                print(text)
                
            })
            .store(in: &subscriptions)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resign))
        view.addGestureRecognizer(tapGesture)
    }
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let timer = Timer.publish(every: 1, on: RunLoop.main, in: .default).autoconnect()
        
        timer.sink { [weak self] date in
            self?.getEpisodeData()
            print(date)
        }.store(in: &subscriptions)
    }
    
    
    func getEpisodeData() -> Void {
        let id = Int.random(in: 1..<51)
        let publisher =  viewModel?.apiClient.episode(id: id)
            .map { $0.description }
            .catch { _ in Empty<String, Never>() }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {print($0) },
                receiveValue: {[weak self] text in
                self?.timerLabel.text = text
                print(text)
            })
            .store(in: &subscriptions)
    }
    
    class EpisodeObservable: ObservableObject {
            @Published var episode: Episode?

            init(episode: Episode?) {
                self.episode = episode
            }
        
        func setEpisode(episode: Episode?) -> Int {
            self.episode = episode
            }
        }

    let john = Contact(name: "John Appleseed", age: 24)
    cancellable = john.objectWillChange
        .sink { _ in
            print("\(john.age) will change")
    }
    print(john.haveBirthday())
    
    @objc private func resign() {
        view.endEditing(true)
        resignFirstResponder()
    }
}

