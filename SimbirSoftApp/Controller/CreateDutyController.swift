//
//  CreateDutyController.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 15.12.2024.
//

import UIKit

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
    }


    func setupButton(){
        print("Работает коректно")
        createDutyVC.addButton.addTarget(self, action: #selector(saveDutyTitle), for: .touchUpInside)
    }

    @objc func saveDutyTitle(){
        guard let title = createDutyVC.dutyNameTF.text, !title.isEmpty  else { return }
        guard let description = createDutyVC.dutyDescription.text, !description.isEmpty else { return }
        let selctedDate = createDutyVC.dataTaskPicker.date

        let task = Tasks(title: title, description: description, date: selctedDate)
        delegate?.addTasks(task, for: selctedDate)

        navigationController?.popViewController(animated: true)
    }
}

protocol DutyControllerDelegate {

    func addTasks(_ task: Tasks, for date: Date)
}
