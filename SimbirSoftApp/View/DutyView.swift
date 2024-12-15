//
//  MainDutyListView.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 13.12.2024.
//

import UIKit

class DutyView: UIView {

    let monthLbl = UILabel()
    let plusButton = UIButton(type: .system)
    let dateTaskPicker = UIDatePicker()
    let taskTable = UITableView()

    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        setView()
        setConstraints()
    }

    func setView() {
        // Настройка метки месяца
        monthLbl.font = .boldSystemFont(ofSize: 24)
        monthLbl.text = "Декабрь"

        // Проверка версии iOS для отображения иконки
        if #available(iOS 13.0, *) {
            plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        } else {
            // Для iOS 12 и ниже используем другую иконку или не используем её
            plusButton.setTitle("+", for: .normal)
        }

        plusButton.backgroundColor = .white
        plusButton.tintColor = .red

        // Настройка UIDatePicker для iOS 14 и выше
        if #available(iOS 14.0, *) {
            dateTaskPicker.preferredDatePickerStyle = .inline
        } else {
            // Для более старых версий используем обычный стиль
            dateTaskPicker.datePickerMode = .dateAndTime
        }

        // Регистрация ячейки для таблицы
        taskTable.register(TaskCell.self, forCellReuseIdentifier: TaskCell.resuseID)
    }

    func setConstraints() {
        addSubview(monthLbl)
        addSubview(plusButton)
        addSubview(dateTaskPicker)
        addSubview(taskTable)

        // Отключаем трансляцию масок для всех элементов
        monthLbl.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        dateTaskPicker.translatesAutoresizingMaskIntoConstraints = false
        taskTable.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Ограничения для monthLbl
            monthLbl.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            monthLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),

            // Ограничения для plusButton
            plusButton.topAnchor.constraint(equalTo: topAnchor, constant: 110),
            plusButton.leadingAnchor.constraint(equalTo: monthLbl.trailingAnchor, constant: 150),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50),

            // Ограничения для dateTaskPicker
            dateTaskPicker.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 70),
            dateTaskPicker.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Ограничения для taskTable
            taskTable.topAnchor.constraint(equalTo: dateTaskPicker.bottomAnchor, constant: 20),
            taskTable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            taskTable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            taskTable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
