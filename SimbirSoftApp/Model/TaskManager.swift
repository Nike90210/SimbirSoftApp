//
//  TaskManager.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 13.12.2024.
//

import Foundation

class TaskManager {

   private(set) var tasksArray: [Task] = []

    func loadTasks(from jsonData: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970

        do {
            tasksArray = try decoder.decode([Task].self, from: jsonData)
        } catch {
            print("Ошибка загрузки \(error)")
        }
    }

    func tasks(for date: Date) -> [Task] {
        let calendar = Calendar.current
        return tasksArray.filter { tasks in
            calendar.isDate(tasks.dateStart, inSameDayAs: date)
        }
    }
}
