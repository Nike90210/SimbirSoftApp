//
//  DetailController.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 16.12.2024.
//

import UIKit

protocol DetailControllerDelegate: AnyObject {
    func updateTask(_ task: Task, at date: String, index: Int)
    func moveDate(_ task: Task, from oldDate: String, to newDate: String, at index: Int )
}

class DetailController: UIViewController {

    let detailView = DetailView()
    var selectedDate: String?
    var taskIndex: Int?
    weak var delegate: DetailControllerDelegate?
    var taskDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        modalPresentationStyle = .fullScreen
        title = "Детали события"

        if let date = taskDate {
            detailView.datePicker.date = date
        }
        setupButton()
        self.dismissKeyboardTap()
    }
    func setupButton() {
      detailView.readyButton.addTarget(self, action: #selector(closeModalVC), for: .touchUpInside)
    }

    @objc func closeModalVC() {
        guard let title = detailView.nameTF.text, !title.isEmpty else { return }
        guard let description = detailView.dutyDescription.text else { return }
        guard let initialDate = selectedDate, let index = taskIndex else { return }
        let taskId = UUID().uuidString
        let newDate = detailView.datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDateString = dateFormatter.string(from: newDate)
        let updatedTask = Task(id: taskId, dateStart: newDate, name: title, description: description)
        if newDateString != initialDate {
            delegate?.moveDate(updatedTask, from: initialDate, to: newDateString, at: index)
        } else {
            delegate?.updateTask(updatedTask, at: initialDate, index: index)
        }
        dismiss(animated: true)
    }
}

