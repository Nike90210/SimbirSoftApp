//
//  CreateDutyController.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 15.12.2024.
//

import UIKit
import RealmSwift

class CreateDutyController: UIViewController {

    let createDutyVC = CreateDutyView()
    let detailDuty = DetailView()
    var delegate: DutyControllerDelegate?
    var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = createDutyVC
        title = "Новое"
        if let date = selectedDate {
            createDutyVC.dataTaskPicker.date = date
        }
        setupButton()
        self.dismissKeyboardTap()
    }

    func setupButton(){
        createDutyVC.addButton.addTarget(self, action: #selector(saveDutyTitle), for: .touchUpInside)
    }

    @objc func saveDutyTitle(){
        guard let title = createDutyVC.dutyNameTF.text, !title.isEmpty  else { return }
      guard let description = createDutyVC.dutyDescription.text else { return }
        let selctedDate = createDutyVC.dataTaskPicker.date
        let taskID = UUID().uuidString
        saveTaskToRealm(title: title, description: description, date: selctedDate)
        let task = Task(id: taskID, dateStart: selectedDate!, name: title, description: description)
        delegate?.addTasks(task, for: selctedDate)
        navigationController?.popViewController(animated: true)
    }
}

protocol DutyControllerDelegate {

    func addTasks(_ task: Task, for date: Date)
}

extension CreateDutyController {
    func saveTaskToRealm(title: String, description: String, date: Date) {
        do {
            let realm = try Realm()
            let tasks = realm.objects(TaskRealm.self)
            var taskExists = false
            for task in tasks {
                if task.title == title && task.date == date {
                    taskExists = true
                    break
                }
            }
            if !taskExists {
                let realmTask = TaskRealm()
                realmTask.id = Int(Date().timeIntervalSince1970)
                realmTask.title = title
                realmTask.taskDescription = description
                realmTask.date = date

                try realm.write {
                    realm.add(realmTask)
                }
            }
        } catch {
            print("Ошибка сохранения в Realm: \(error)")
        }
    }
}


