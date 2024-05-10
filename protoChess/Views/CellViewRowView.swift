//
//  CellViewRowView.swift
//  protoChess
//
//  Created by alexandre VINCENT on 02/05/2024.
//

import UIKit

class CellViewRowView: UICollectionViewCell {
    
    static let identifier = "CellViewRowView"
    var data : String! {
        didSet {
            label.text = data
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "TextColor")
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //contentView.backgroundColor
        contentView.addSubview(label)
        label.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        data = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }

}
