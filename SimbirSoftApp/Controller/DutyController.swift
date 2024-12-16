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
        addAction()
        mainView.taskTable.dataSource = self
        mainView.taskTable.delegate = self
    }

    func addAction() {
        if #available(iOS 14.0, *) {
            let pushAddAction = UIAction { [unowned self] _ in
                let vc = CreateDutyController()
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

    private func openDetailVC(for item: String) {
        let detailVC = DetailController()
        detailVC.detailView.titleLable.text = item
        present(detailVC, animated: true)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailVC(for: taskArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
