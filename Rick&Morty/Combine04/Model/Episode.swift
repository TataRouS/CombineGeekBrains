//
//  Eposode.swift
//  Homework04
//
//  Created by Nata Kuznetsova on 28.09.2023.
//

import Foundation

public struct Episode: Codable, CustomStringConvertible {
    public var description: String {

"""
            self.id = \(id)
            self.name = \(name)
            self.air_date = \(air_date)
            self.episode = \(episode)
            self.created = \(created)
            
"""
    }
    
    public var id: Int64
    public var name: String
    public var air_date: String
    public var episode: String
    public var created: String
 
   
    
    
    
    public init(id: Int64, name: String, air_date: String, episode: String, created: String
                
    )
    {
        self.id = id
        self.name = name
        self.air_date = air_date
        self.episode = episode
        self.created = created
    
       
    }
}
