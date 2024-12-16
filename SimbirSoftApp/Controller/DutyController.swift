//
//  ViewController.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 13.12.2024.
//

import UIKit

class DutyController: UIViewController {

    let mainView = DutyView()
    let detailController = DetailController()
    var taskArray: [String] = [] {
            didSet {
                mainView.taskTable.reloadData() 
            }
        }

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

    private func openDetailVC(for dutyTask: String) {
        let detailVC = DetailController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.detailView.titleLable.text = "Детали события"
        detailVC.detailView.nameTF.text = dutyTask
        detailVC.detailView.dutyDescription.text = dutyTask.description
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
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = taskArray[indexPath.row]
        openDetailVC(for: task)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension DutyController: DutyControllerDelegate {
    func addTask(task: String) {
        taskArray.append(task)
    }
}
