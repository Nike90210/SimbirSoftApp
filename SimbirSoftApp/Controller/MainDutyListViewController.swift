//
//  ViewController.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 13.12.2024.
//

import UIKit

class DutyController: UIViewController {

    let mainView = DutyView()
    let taskArray = ["Купить помидоры", "Убраться", "Купить вино"]
    let timeArray = ["14:00 - 15:00", "15:00 - 16:00", "16:00 - 17:00"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.taskTable.dataSource = self
        mainView.taskTable.delegate = self
    }

}

extension DutyController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.resuseID) as! TaskCell
        cell.titleLbl.text = taskArray[indexPath.row]
        cell.timeLbl.text = timeArray[indexPath.row]
        return cell
    }
    
}
