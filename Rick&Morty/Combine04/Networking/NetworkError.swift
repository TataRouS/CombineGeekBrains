//
//  NetworkError.swift
//  Homework04
//
//  Created by Nata Kuznetsova on 28.09.2023.
//

import Foundation

enum NetworkError: LocalizedError {
    case unreachableAddress(url: URL)
    case invalidResponse
    var errorDescription: String? {
        switch self {
        case .unreachableAddress(let url): return "\(url.absoluteString) is unreachable"
        case .invalidResponse: return "Response with mistake"
        }
    }
}
