//
//  TaskManager .swift
//  SimbirSoftApp
//
//  Created by Jazzband on 22.12.2024.
//

import Foundation

class TasksManager {
    var tasksArray: [Task] = []

    func loadTasks(from data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Загруженный JSON: \(jsonString)")
            }

            let tasks = try decoder.decode([Task].self, from: data)
            self.tasksArray = tasks
            print("Задачи  загружены: \(tasks.count) задач")
        } catch {
            print("Ошибка: \(error)")
        }
    }

    func loadJSONDataFromFile() -> Data? {
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("tasks.json")
            print("Путь к файлу: \(fileURL.path)")

            if fileManager.fileExists(atPath: fileURL.path) {
                print("Файл существует по пути: \(fileURL.path)")
                do {
                    let data = try Data(contentsOf: fileURL)
                    if data.isEmpty {
                        print("Файл пустой")
                    } else {
                        print("Данные загружены: \(data.count) байт")
                    }
                    return data
                } catch {
                    print("Ошибка при чтении: \(error)")
                }
            } else {
                print("Файл не найден: \(fileURL.path)")
            }
        }
        return nil
    }

    func addTask(_ task: Task) {
        tasksArray.append(task)
    }
    func serializeTasksToJSON(tasks: [Task]) -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(tasks)
            return data
        } catch {
            print("Ошибка: \(error)")
            return nil
        }
    }
    func saveJSONToFile(data: Data) {
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("tasks.json")
            do {
                try data.write(to: fileURL)
                print("Данные сохранены в : \(fileURL.path)")
            } catch {
                print("Ошибка при сохранении: \(error)")
            }
        }
    }



}




