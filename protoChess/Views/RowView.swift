//
//  RowView.swift
//  protoChess
//
//  Created by alexandre VINCENT on 01/05/2024.
//

import UIKit

class RowView: UICollectionViewCell {
    
    let backgroundColorResult : [String: UIColor] = [
        "W" : UIColor(red: 0.02, green: 0.77, blue: 0.42, alpha: 1.00),
        "D" : UIColor(red: 1.00, green: 0.37, blue: 0.34, alpha: 1.00),
        "N" : UIColor(red: 0.50, green: 0.56, blue: 0.61, alpha: 1.00),
    ]

    static let identifier = "RowView"
    var item: [String: Any]!
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CellViewRowView.self, forCellWithReuseIdentifier: CellViewRowView.identifier)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        item = nil
        //collectionView.delegate = nil
        //collectionView.dataSource = nil
        collectionView.reloadData()
        // Réinitialiser l'état de chaque sous-vue de la cellule ici
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

}

extension RowView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellViewRowView.identifier, for: indexPath) as? CellViewRowView else {return UICollectionViewCell()}
        cell.backgroundColor = backgroundColorResult[item["result"]as! String]
        switch indexPath.item {
        case 0:
            cell.data = "\(item["mode"]as! String)"
        case 1:
            cell.data = "\((item["opponent"]as! PlayerInfo).username) (\((item["opponent"]as! PlayerInfo).rating))"
        case 2:
            cell.data = "\((item["result"] ?? "none") as! String) - \(item["endTime"]as! String)"
        default:
            cell.data = "None"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout ,sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.item == 1) {
            return CGSize(width: (collectionView.frame.width * 0.5) - 1, height: collectionView.frame.height)
        } else {
            return CGSize(width: (collectionView.frame.width * 0.25) - 1, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.item == 1) {
            UIApplication.shared.open(URL(string: item["url"]as! String)!)
        }
    }
    
}
