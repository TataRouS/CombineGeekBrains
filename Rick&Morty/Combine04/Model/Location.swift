//
//  File.swift
//  Homework04
//
//  Created by Nata Kuznetsova on 04.10.2023.
//

import Foundation

public struct Location: Codable, CustomStringConvertible {
    public var description: String {

"""
            self.id = \(id)
            self.name = \(name)
            self.type = \(type)
    
            
"""
    }
    
    public var id: Int64
    public var name: String
    public var type: String
   
 
   
    public init(id: Int64, name: String, type: String)
    
    {
        self.id = id
        self.name = name
        self.type = type
        
    }
}
