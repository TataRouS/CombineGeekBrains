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
    var subscriptions: Set<AnyCancellable> = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       viewModel = ViewModelNew(apiClient: APIClient() )
        subscriptions = Set<AnyCancellable>()
    }
    

    override func tearDown()  {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        subscriptions = []
    }

    func testFetchedEpisode(){
        //Given
        
        
        let testAPIClient = APIClientMock()
        viewModel = ViewModelNew(apiClient: APIClientMock())
        var actual = " "
        var expected = testAPIClient.episode1.description
        var expectation = self.expectation(description: "Episode")
        
        //When
        
        viewModel?.$episodeDescription
            .sink(receiveValue: {[weak self] text in
                if text != "" {    actual = text
                    expectation.fulfill()
                   print("actual\(text)")
                    print("EpisodeDescription\(self?.viewModel?.episodeDescription)")}
            })

          .store(in: &subscriptions)
        viewModel?.fetchEpisode()
        viewModel?.id = "33"
        
        //Then
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(
            actual == expected,
            "Actual episode:\(actual); Expected episodet: \(expected)")
    }
}

