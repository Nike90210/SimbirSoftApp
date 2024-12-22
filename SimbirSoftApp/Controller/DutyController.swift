//
//  ViewController.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 13.12.2024.
//

import UIKit
import RealmSwift


class DutyController: UIViewController {

    let mainView = DutyView()
    let detailView = DetailView()
    let detailController = DetailController()
    let taskManager = TasksManager()

    var tasksByDate: [String : [Task]] = [:] {
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
        loadTaskFromRealm()
        loadTasksFromJSON()
    }

    func loadTasksFromJSON() {
           if let jsonData = loadJSONDataFromFile() {
               taskManager.loadTasks(from: jsonData)
               updateTasksByDate()
           }
       }

    func loadJSONDataFromFile() -> Data? {
          guard let url = Bundle.main.url(forResource: "tasks", withExtension: "json") else {
              print("Ошибка загрузки JSON")
              return nil
          }
          return try? Data(contentsOf: url)
      }

    func updateTasksByDate() {
        var groupedTasks: [String: [Task]] = [:]
        for task in taskManager.tasksArray {
            let taskDate = task.dateStart
            let dateKey = formattedDate(taskDate)
            let newTask = Task(id: task.id, dateStart: task.dateStart, name: task.name, description: task.description)
            groupedTasks[dateKey, default: []].append(newTask)
        }
        tasksByDate = groupedTasks
        mainView.taskTable.reloadData()
    }

    func saveTasksToJSON() {
        if let jsonData = taskManager.serializeTasksToJSON(tasks: taskManager.tasksArray) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON: \(jsonString)")
            }

            saveJSONToFile(data: jsonData)
        }
    }

    func saveJSONToFile(data: Data) {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("tasks.json") else {
            print("Ошибка сохранения JSON")
            return
        }
        do {
            try data.write(to: url)
        } catch {
            print("Ошибка записи: \(error)")
        }
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
    private func openDetailVC(for task: Task, at index: Int) {
        let detailVC = DetailController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.selectedDate = formattedDate(task.dateStart)
        detailVC.taskIndex = index
        detailVC.delegate = self
        detailVC.detailView.titleLable.text = "Детали события"
        detailVC.detailView.nameTF.text = task.name
        detailVC.detailView.dutyDescription.text = task.description
        detailVC.detailView.datePicker.date = task.dateStart
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
            let hour = Calendar.current.component(.hour, from: task.dateStart)
            let startTime = String(format: "%2d:00", hour)
            let endTime = String(format: "%2d:00", hour + 1)
            cell.titleLbl.text = task.name
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
            guard var tasks = tasksByDate[selectedDate] else { return }
            let taskToDelete = tasks[indexPath.row]
            tasks.remove(at: indexPath.row)
            tasksByDate[selectedDate] = tasks.isEmpty ? nil : tasks
            do {
                let realm = try Realm()
                let tasksInRealm = realm.objects(TaskRealm.self)
                var realmTaskToDelete: TaskRealm?

                for realmTask in tasksInRealm {
                    if realmTask.title == taskToDelete.name && realmTask.date == taskToDelete.dateStart {
                        realmTaskToDelete = realmTask
                        break
                    }
                }
                if let realmTaskToDelete = realmTaskToDelete {
                    try realm.write {
                        realm.delete(realmTaskToDelete)
                    }
                }
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                if tasksByDate[selectedDate]?.isEmpty == true {
                    tasksByDate[selectedDate] = nil
                }
            } catch {
                print("Ошибка удаления Realm: \(error)")
            }
        }
    }
}
extension DutyController: DutyControllerDelegate {
    func addTasks(_ task: Task, for date: Date) {
          let dateKey = formattedDate(date)
          tasksByDate[dateKey, default: []].append(task)
          saveRealmTasks(task)
          saveTasksToJSON()
          if dateKey == selectedDate {
              mainView.taskTable.reloadData()
          }
      }
}
extension DutyController: DetailControllerDelegate {
    func moveDate(_ task: Task, from oldDate: String, to newDate: String, at index: Int) {
        do {
            let realm = try Realm()
            if var oldTasks = tasksByDate[oldDate], index < oldTasks.count {
                let taskToRemove = oldTasks.remove(at: index)
                tasksByDate[oldDate] = oldTasks.isEmpty ? nil : oldTasks
                let tasks = realm.objects(TaskRealm.self)
                var realmTaskToRemove: TaskRealm?
                for realmTask in tasks {
                    if realmTask.title == taskToRemove.name && realmTask.date == taskToRemove.dateStart {
                        realmTaskToRemove = realmTask
                        break
                    }
                }
                if let realmTask = realmTaskToRemove {
                    try realm.write {
                        realm.delete(realmTask)
                    }
                }
            }
            tasksByDate[newDate, default: []].append(task)
            if oldDate == selectedDate || newDate == selectedDate {
                mainView.taskTable.reloadData()
            }
        } catch {
            print("Ошибка: \(error)")
        }
    }

    func updateTask(_ task: Task, at date: String, index: Int) {
        do {
            let realm = try Realm()
            let tasks = realm.objects(TaskRealm.self)
            var realmTaskToUpdate: TaskRealm?
            for realmTask in tasks {
                if realmTask.title == tasksByDate[date]?[index].name &&
                    realmTask.date == tasksByDate[date]?[index].dateStart {
                    realmTaskToUpdate = realmTask
                    break
                }
            }
            if let realmTask = realmTaskToUpdate {
                try realm.write {
                    realmTask.title = task.name
                    realmTask.taskDescription = task.description
                    realmTask.date = task.dateStart
                }
            }
            if var tasks = tasksByDate[date], index < tasks.count {
                tasks[index] = task
                tasksByDate[date] = tasks
                if date == selectedDate {
                    mainView.taskTable.reloadData()
                }
            }
        } catch {
            print("Ошибка Realm: \(error)")
        }
    }
}

extension DutyController {
    func saveRealmTasks(_ task: Task) {
        let realm = try! Realm()

        let tasks = realm.objects(TaskRealm.self)
        var isTaskFound = false

        for realmTask in tasks {
            if realmTask.title == task.name && realmTask.date == task.dateStart {
                isTaskFound = true
                break
            }
        }
        if !isTaskFound {
            let taskRealm = TaskRealm()
            taskRealm.id = UUID().hashValue
            taskRealm.title = task.name
            taskRealm.taskDescription = task.description
            taskRealm.date = task.dateStart

            try! realm.write {
                realm.add(taskRealm)
            }
        }
    }
}
extension DutyController {
    func loadTaskFromRealm() {
        do {
            let realm = try Realm()
            let tasks = realm.objects(TaskRealm.self)
            var groupTasks: [String : [Task]] = [:]
            tasksByDate.removeAll()
            for task in tasks {
                let taskDate = formattedDate(task.date)
                let taskId = String(task.id)
                let newTask = Task(id: taskId, dateStart: task.date, name: task.title, description: task.taskDescription)
                groupTasks[taskDate, default: []].append(newTask)
            }
            tasksByDate = groupTasks
        } catch {
            print("Ошибка во время загрузки \(error)")
        }
    }
}




