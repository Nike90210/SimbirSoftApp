//
//  TableViewCell.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 14.12.2024.
//

import UIKit

class TaskCell: UITableViewCell {

    static let resuseID = "TaskCell"
    let titleLbl = UILabel(frame: CGRect())
    let timeLbl = UILabel(frame: CGRect())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    func setViews() {
        titleLbl.text = ""
        titleLbl.font = .boldSystemFont(ofSize: 10)
        timeLbl.text = ""
        timeLbl.font = .boldSystemFont(ofSize: 10)
    }

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 25
        return stack
    }()

    func setConstraints() {
        stackView.addArrangedSubview(titleLbl)
        stackView.addArrangedSubview(timeLbl)
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
