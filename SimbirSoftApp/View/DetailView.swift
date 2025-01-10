//
//  DetailView.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 16.12.2024.
//

import UIKit

class DetailView: UIView {

    let readyButton = UIButton(type: .system)
    let titleLable = UILabel()
    let nameTF = UITextField()
    let datePicker = UIDatePicker()
    let dutyDescription = UITextField()

    init(){
        super.init(frame: CGRect())
        backgroundColor = .white
        setView()
        setConstraints()
    }

    func setView(){
        readyButton.setTitle("Готово", for: .normal)
        readyButton.setTitleColor(.systemRed, for: .normal)
        readyButton.backgroundColor = .clear

        titleLable.text = "Детали события"
        titleLable.textColor = .black
        titleLable.font = UIFont(name: "Helvetica", size: 18)

        nameTF.placeholder = "Название события"
        nameTF.font = UIFont(name: "Helvetica", size: 14)
        nameTF.borderStyle = .roundedRect
        nameTF.textColor = .black

        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.datePickerMode = .dateAndTime
        }

        dutyDescription.placeholder = "Описание события"
        dutyDescription.borderStyle = .roundedRect
        dutyDescription.textColor = .black
    }

    func setConstraints(){
        addSubview(nameTF)
        addSubview(datePicker)
        addSubview(dutyDescription)
        addSubview(readyButton)
        addSubview(titleLable)

        [readyButton,titleLable ,nameTF, datePicker, dutyDescription].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            readyButton.topAnchor.constraint(equalTo: topAnchor, constant: 75),
            readyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            titleLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 80),

            nameTF.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 40),
            nameTF.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 25),
            nameTF.heightAnchor.constraint(equalToConstant: 40),
            nameTF.widthAnchor.constraint(equalToConstant: 350),

            datePicker.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            dutyDescription.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            dutyDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            dutyDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dutyDescription.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
