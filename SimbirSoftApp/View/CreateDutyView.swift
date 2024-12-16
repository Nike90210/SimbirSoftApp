//
//  CreateDutyView.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 15.12.2024.
//

import UIKit


class CreateDutyView: UIView {

    var addButton = UIButton(type: .system)
    var dutyNameTF = UITextField()
    var dutyDescription = UITextField()
    var dutyStartLbl = UILabel()
    var dataTaskPicker = UIDatePicker()

    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        setView()
        setConstraints()
    }

    func setView() {

        addButton.setTitle("Добавить", for: .normal)
        addButton.setTitleColor(.systemRed, for: .normal)
        addButton.backgroundColor = .clear

        dutyNameTF.placeholder = "Название"
        dutyNameTF.textColor = .black
        dutyNameTF.borderStyle = .roundedRect

        dutyDescription.placeholder = "Введите описание текста"
        dutyDescription.borderStyle = .roundedRect
        dutyDescription.textColor = .black

        dutyStartLbl.text = "Начало:"
        dutyStartLbl.font = UIFont(name: "Helvetica", size: 18)
        dutyStartLbl.textColor = .black


        if #available(iOS 13.4, *) {
            dataTaskPicker.preferredDatePickerStyle = .automatic
        } else {
            dataTaskPicker.datePickerMode = .dateAndTime
        }
    }


    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        return stackView
    }()


    func setConstraints() {
        addSubview(addButton)
        addSubview(dutyNameTF)
        addSubview(dutyDescription)
        addSubview(stackView)

        stackView.addArrangedSubview(dutyStartLbl)
        stackView.addArrangedSubview(dataTaskPicker)


        [stackView, addButton, dutyNameTF, dutyDescription].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([

            dutyNameTF.topAnchor.constraint(equalTo: topAnchor, constant: 300),
            dutyNameTF.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dutyNameTF.widthAnchor.constraint(equalToConstant: 250),

            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 300),
            addButton.leadingAnchor.constraint(equalTo: dutyNameTF.trailingAnchor, constant: 40),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 70),

            dutyDescription.topAnchor.constraint(equalTo: dutyNameTF.bottomAnchor, constant: 100),
            dutyDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dutyDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dutyDescription.heightAnchor.constraint(equalToConstant: 100),


            stackView.topAnchor.constraint(equalTo: dutyDescription.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
