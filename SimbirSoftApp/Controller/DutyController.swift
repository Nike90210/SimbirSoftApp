//
//  ViewController.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 13.12.2024.
//

import UIKit

struct Tasks {
    let title: String
    let description: String
    let date: Date
}

class DutyController: UIViewController {
    
    let mainView = DutyView()
    let detailView = DetailView()
    let detailController = DetailController()
    
    var tasksByDate: [String : [Tasks]] = [:] {
        didSet {
            mainView.taskTable.reloadData()
        }
    }
    
    var selectedDate: String = ""{
        didSet {
            mainView.taskTable.reloadData()
        }
    }
    
    func formattedDate(_ date: Date, format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        addAction()
        setupTable()
        setupDatePicker()
        selectedDate = formattedDate(Date())
        currentMonth()
    }
    
    func setupDatePicker() {
        mainView.dateTaskPicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    func currentMonth() {
        let currentDate = Date()
        selectedDate = formattedDate(currentDate)
        updateMonthLabel(for: currentDate)
    }
    
    func updateMonthLabel (for date: Date) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "LLLL"
        mainView.monthLbl.text = formatter.string(from: date).capitalized
    }
    
    @objc func dateChanged() {
        //        selectedDate = formattedDate(mainView.dateTaskPicker.date)
        let newDate = mainView.dateTaskPicker.date
        selectedDate = formattedDate(newDate)
        updateMonthLabel(for: newDate)
        
    }
    
    func setupTable() {
        mainView.taskTable.dataSource = self
        mainView.taskTable.delegate = self
        mainView.taskTable.register(TaskCell.self, forCellReuseIdentifier: TaskCell.resuseID)
    }
    
    func addAction() {
        if #available(iOS 14.0, *) {
            let pushAddAction = UIAction { [unowned self] _ in
                let vc = CreateDutyController()
                vc.selectedDate = mainView.dateTaskPicker.date
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
            mainView.plusButton.addAction(pushAddAction, for: .touchUpInside)
        } else {
            mainView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc func plusButtonTapped() {
        let vc = CreateDutyController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func openDetailVC(for task: Tasks, at index: Int) {
        let detailVC = DetailController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.selectedDate = formattedDate(task.date)
        detailVC.taskIndex = index
        detailVC.delegate = self

        detailVC.detailView.titleLable.text = "Детали события"
        detailVC.detailView.nameTF.text = task.title
        detailVC.detailView.dutyDescription.text = task.description
        detailVC.detailView.datePicker.date = task.date
        present(detailVC, animated: true)
    }
    
}

extension DutyController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksByDate[selectedDate]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.resuseID) as! TaskCell
        
        if let task = tasksByDate[selectedDate]?[indexPath.row] {
            let hour = Calendar.current.component(.hour, from: task.date)
            let startTime = String(format: "%2d:00", hour)
            let endTime = String(format: "%2d:00", hour + 1)
            
            cell.titleLbl.text = task.title
            cell.timeLbl.text = "\(startTime) - \(endTime)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let task = tasksByDate[selectedDate]?[indexPath.row] else {return}
        openDetailVC(for: task, at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard var tasks = tasksByDate[selectedDate], indexPath.row < tasksByDate.count else { return }
            tasks.remove(at: indexPath.row)
            tasksByDate[selectedDate] = tasks.isEmpty ? nil : tasks
            tableView.reloadData()
        }
    }
}

extension DutyController: DutyControllerDelegate {
    func addTasks(_ task: Tasks, for date: Date) {
        let dateKey = formattedDate(date)
        tasksByDate[dateKey, default: []].append(task)
        if dateKey == selectedDate {
            mainView.taskTable.reloadData()
        }
    }
}

extension DutyController: DetailControllerDelegate {
    func moveDate(_ task: Tasks, from oldDate: String, to newDate: String, at index: Int) {

        if var oldTasks = tasksByDate[oldDate], index < oldTasks.count {
            oldTasks.remove(at: index)
            tasksByDate[oldDate] = oldTasks.isEmpty ? nil : oldTasks
        }

        tasksByDate[newDate, default: []].append(task)

        if oldDate == selectedDate || newDate == selectedDate {
            mainView.taskTable.reloadData()
        }
    }

    func updateTask(_ task: Tasks, at date: String, index: Int) {
        if var tasks = tasksByDate[date], index < tasks.count {
            tasks[index] = task
            tasksByDate[date] = tasks

            if date == selectedDate {
                mainView.taskTable.reloadData()
            }
        }
    }
}

