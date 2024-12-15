//
//  Task.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 13.12.2024.
//

import Foundation

struct Task: Codable {
    let id: Int
    let dateStart: Date
    let dateFinish: Date
    let title: String
    let description: String

    static let dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
}
