//
//  SearchViewController.swift
//  protoChess
//
//  Created by alexandre VINCENT on 03/05/2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchText : String?
    
    private let bgImg : UIImageView = {
        let bgImg = UIImageView(image: UIImage(named: "bgChess"))
        bgImg.contentMode = .scaleAspectFill
        bgImg.clipsToBounds = true
        return bgImg
    }()
    
    private let searchButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rechercher", for: .normal)
        button.setTitleColor(UIColor(named: "TextColor"), for: .normal)
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(changePage), for: .touchUpInside)
        return button
    }()
    
    private let inputText : UITextField = {
        let input = UITextField()
        input.backgroundColor = UIColor.white
        input.borderStyle = .roundedRect
        input.placeholder = "Entrer le pseudo"
        return input
    }()
    
    private let formView : UIStackView = {
        let formView = UIStackView()
        formView.axis = .vertical
        formView.distribution = .fillEqually
        formView.spacing = 10
        let label = UILabel()
        label.text = "Rechercher un joueur"
        label.textColor = UIColor(named: "TextColor")
        formView.addArrangedSubview(label)
        formView.translatesAutoresizingMaskIntoConstraints = false
        return formView
    }()
    
    @objc func changePage() {
        searchText = inputText.text
        if (searchText != nil && searchText?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false) {
            searchText = inputText.text
            navigationController?.navigationBar.topItem?.title = "retour"
            navigationController?.pushViewController(MainTabBarViewController(username: searchText!), animated: false)
        }
    }
    
    private let searchView : UIStackView = {
        let searchView = UIStackView(frame: .zero)
        searchView.alignment = .center
        searchView.translatesAutoresizingMaskIntoConstraints = false
        return searchView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgImg)
        view.addSubview(searchView)
        navigationController?.navigationBar.topItem?.title = ""
        bgImg.frame = view.bounds
        searchView.addArrangedSubview(formView)
        formView.addArrangedSubview(inputText)
        formView.addArrangedSubview(searchButton)
        NSLayoutConstraint.activate([
            searchView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            searchView.heightAnchor.constraint(equalToConstant: 150),
            formView.centerXAnchor.constraint(equalTo: searchView.centerXAnchor),
            formView.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backItem?.title = ""
    }
}
