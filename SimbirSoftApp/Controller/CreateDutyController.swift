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

    override func viewDidLoad() {
        super.viewDidLoad()
        view = createDutyVC
        title = "Новое"
        setupButton()
    }

    func setupButton(){
        print("Работает коректно")
        createDutyVC.addButton.addTarget(self, action: #selector(saveDutyTitle), for: .touchUpInside)
    }

    @objc func saveDutyTitle(){
        guard let title = createDutyVC.dutyNameTF.text, !title.isEmpty  else { return }
        guard let description = createDutyVC.dutyDescription.text, !description.isEmpty else { return }
        delegate?.addTaskTitle(task: title)
        delegate?.addTaskDescription(task: description)
        navigationController?.popViewController(animated: true)
    }
}

protocol DutyControllerDelegate {
    func addTaskTitle(task: String)
    func addTaskDescription(task: String)
}
