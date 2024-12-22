//
//  Task.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 13.12.2024.
//

import Foundation


import Foundation

struct Task: Codable {
    var id: String
        var dateStart: Date
        var name: String
        var description: String

    init(id: String = UUID().uuidString, dateStart: Date, name: String, description: String) {
            self.id = id
            self.dateStart = dateStart
            self.name = name
            self.description = description
        }

    enum CodingKeys: String, CodingKey {
        case id
        case dateStart = "date_start"  
        case name
        case description
    }
}




