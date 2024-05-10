//
//  NoResultView.swift
//  protoChess
//
//  Created by alexandre VINCENT on 10/05/2024.
//

import UIKit

class NoResultView: UIStackView {
    
    private let message : UILabel = {
        let message = UILabel()
        message.text = "Aucun résultat pour votre recherche"
        message.font = .systemFont(ofSize: 13)
        message.textColor = UIColor(named: "TextColor")
        message.textAlignment = .center
        return message
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        alignment = .center
        addArrangedSubview(message)
    }
    
    required init(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
    }
}
