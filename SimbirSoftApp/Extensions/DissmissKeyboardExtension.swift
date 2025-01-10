//
//  DissmissKeyboardExtension.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 19.12.2024.
//

import UIKit

extension UIViewController {


    func dismissKeyboardTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeybord))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeybord() {
        view.endEditing(true)
    }
}
