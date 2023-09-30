//
//  ViewController.swift
//  Storyboard
//
//  Created by Nata Kuznetsova on 03.08.2023.
//

import UIKit
import Combine


class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet var textLabel: UILabel!
    
//    @IBOutlet var textLabel: UILabel!
//    @IBOutlet var inputTextField: UITextField!
    
    var Subscriptions: Set<AnyCancellable> = []
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
        
    })
            .store(in: &Subscriptions)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resign))
        view.addGestureRecognizer(tapGesture)
    }
        
        @objc private func resign() {
        view.endEditing(true)
        resignFirstResponder()
    }
}

