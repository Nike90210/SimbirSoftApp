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

        dutyDescription.placeholder = "Введите описание текста"
        dutyDescription.borderStyle = .roundedRect
        dutyDescription.textColor = .black

        dutyStartLbl.text = "Начало:"
        dutyStartLbl.font = UIFont(name: "Helvetica", size: 18)
        dutyStartLbl.textColor = .black

        dataTaskPicker.preferredDatePickerStyle = .automatic
    }

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        return stackView
    }()

    func setConstraints(){
        addSubview(addButton)
        addSubview(dutyNameTF)
        addSubview(dutyDescription)
        addSubview(stackView)
        stackView.addArrangedSubview(dutyStartLbl)
        stackView.addArrangedSubview(dataTaskPicker)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        dutyNameTF.translatesAutoresizingMaskIntoConstraints = false
        dutyDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            dutyNameTF.topAnchor.constraint(equalTo: topAnchor, constant: 300),
            dutyNameTF.centerXAnchor.constraint(equalTo: centerXAnchor),

            dutyDescription.topAnchor.constraint(equalTo: dutyNameTF.bottomAnchor, constant: 100),
            dutyDescription.leadingAnchor.constraint(equalTo: leadingAnchor,  constant: 16),
            dutyDescription.trailingAnchor.constraint(equalTo: trailingAnchor,  constant: -16),
            dutyDescription.heightAnchor.constraint(equalToConstant: 100),
            dutyDescription.centerXAnchor.constraint(equalTo: centerXAnchor),

            stackView.topAnchor.constraint(equalTo: dutyDescription.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)

        ])
    }




    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
