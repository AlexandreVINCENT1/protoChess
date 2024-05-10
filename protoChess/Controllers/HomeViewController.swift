//
//  HomeViewController.swift
//  protoChess
//
//  Created by alexandre VINCENT on 01/05/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    let username : String
    var userProfile : UserProfile?
    var avatarImgData: Data?
    
    private let bgImg : UIImageView = {
        let bgImg = UIImageView(image: UIImage(named: "bgChess"))
        bgImg.contentMode = .scaleAspectFill
        bgImg.clipsToBounds = true
        return bgImg
    }()
    
    private let avatarImg : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    private let uiStackView : UIStackView = {
        let uiStackView = UIStackView()
        uiStackView.axis = .vertical
        uiStackView.distribution = .fillEqually
        uiStackView.alignment = .leading
        return uiStackView
    }()

    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
        view.addSubview(bgImg)
        view.addSubview(avatarImg)
        view.addSubview(uiStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        if (userProfile == nil) {
            Task {
                do {
                    userProfile = try await AsyncNetworkManager.shared.getUserProfile(username: username)
                    if (userProfile!.avatar != nil) {
                        avatarImgData = try await AsyncNetworkManager.shared.getUserProfileImage(url: userProfile!.avatar!)
                        avatarImg.image = UIImage(data: avatarImgData!)
                    }
                    uiStackView.addArrangedSubview(ProfileRowView(field : "Username :" , value: userProfile!.username))
                    uiStackView.addArrangedSubview(ProfileRowView(field : "Started at :" , value: formatDate(date: userProfile!.joined)))
                    uiStackView.addArrangedSubview(ProfileRowView(field : "Last time online :" , value: formatDate(date: userProfile!.lastOnline)))
                    uiStackView.addArrangedSubview(ProfileRowView(field : "Player Id :" , value: "\(userProfile!.playerId)"))
                } catch {
                    let noResult = NoResultView()
                    view.addSubview(noResult)
                    noResult.frame = view.bounds
                    print("Erreur lors de la récupération du profile : \(error)")
                    
                }
            }
        }

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgImg.frame = view.bounds
        uiStackView.frame = view.bounds
        uiStackView.frame.size = CGSize(width: view.bounds.size.width * 0.8, height: 150)
        uiStackView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        avatarImg.center = CGPoint(x: view.bounds.midX - 75, y: uiStackView.frame.minY - 200)
        avatarImg.frame.size = CGSize(width: 150, height: 150)
    }

    private func formatDate(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
