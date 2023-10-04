//
//  Method.swift
//  Homework04
//
//  Created by Nata Kuznetsova on 28.09.2023.
//


import Foundation

enum Method {
    static let baseURL = URL (string: "https://rickandmortyapi.com/api/")!
    
    case character(Int)
    case location(Int)
    case episode(Int)
    
    var url: URL {
        switch self {
        case .episode(let id):
            return Method.baseURL.appendingPathComponent("episode/\(id)")
        case .location(let id):
            return Method.baseURL.appendingPathComponent("location/\(id)")
        default:
            // Homework
            fatalError("URL for this case is undefined.")
        }
    }
}
