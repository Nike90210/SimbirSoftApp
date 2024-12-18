//
//  DetailController.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 16.12.2024.
//

import UIKit

class DetailController: UIViewController {

    let detailView = DetailView()
    var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        modalPresentationStyle = .fullScreen
        title = "Детали собатия"
        if let date = selectedDate {
            detailView.datePicker.date = date
        }
        setupButton()
    }
        func setupButton() {
            detailView.readyButton.addTarget(self, action: #selector(closeModalVC), for: .touchUpInside)
        }

        @objc func closeModalVC(){
            dismiss(animated: true, completion: nil)
        }
    }

