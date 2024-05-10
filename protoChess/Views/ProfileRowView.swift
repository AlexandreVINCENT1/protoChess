//
//  ProfileRow.swift
//  protoChess
//
//  Created by alexandre VINCENT on 07/05/2024.
//

import UIKit

class ProfileRowView: UIStackView {
    
    let field : String
    let value : String

    init(field : String, value: String) {
        self.field = field
        self.value = value
        super.init(frame: .zero)
        setupUI()
    }

    required init(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        axis = .horizontal
        alignment = .fill
        spacing = 10
        addArrangedSubview(labelField(text: field))
        addArrangedSubview(labelField(text: value))
    }
    
    private func labelField(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(named: "TextColor")
        label.font = .systemFont(ofSize: 13)
        return label
    }
}
