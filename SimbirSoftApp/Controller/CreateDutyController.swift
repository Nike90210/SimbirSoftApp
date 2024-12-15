//
//  CreateDutyController.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 15.12.2024.
//

import UIKit

class CreateDutyController: UIViewController {

    let createDutyVC = CreateDutyView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = createDutyVC
       
        title = "Новое"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemRed
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed]
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemRed]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .systemRed
    }


}
