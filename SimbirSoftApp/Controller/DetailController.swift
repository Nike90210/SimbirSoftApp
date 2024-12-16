//
//  DetailController.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 16.12.2024.
//

import UIKit

class DetailController: UIViewController {

    let detailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        modalPresentationStyle = .fullScreen
        title = detailView.titleLable.text ?? ""
    }

    

}
