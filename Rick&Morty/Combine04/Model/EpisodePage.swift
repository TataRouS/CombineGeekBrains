//
//  EpisodePage.swift
//  Homework04
//
//  Created by Nata Kuznetsova on 28.09.2023.
//

import Foundation

public struct EpisodePage: Codable {
    
    public var info: PageInfo
    public var results: [Episode]
    
    public init(info: PageInfo, results: [Episode]) {
        self.info = info
        self.results = results
    }
}
