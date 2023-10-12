//
//  Homework04Tests.swift
//  Homework04Tests
//
//  Created by Nata Kuznetsova on 11.10.2023.
//

import XCTest
import Combine
@testable import Homework04

final class Homework04Tests: XCTestCase {
    var viewModel: ViewModelNew?
    var subscription: Set<AnyCancellable>?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ViewModelNew(apiClient: APIClient() )
        subscription = Set<AnyCancellable>()
    }
    

    override func tearDown()  {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        subscription = []
    }

  
   
    }

