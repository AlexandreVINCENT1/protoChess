//
//  GamesHistoryViewController.swift
//  protoChess
//
//  Created by alexandre VINCENT on 01/05/2024.
//

import UIKit

class GamesHistoryViewController: UIViewController {
    
    let username: String
    var games : [Game]?
    let score : [String : String] = [
        "win" : "W",
        "checkmated" : "D",
        "resigned" : "D",
        "timeout" : "D",
        "abandoned" : "D",
        "stalemate" : "N",
        "repetition" : "N",
        "agreed" : "N",
        "timevsinsufficient": "N",
        "insufficient" : "N",
        "50move": "N",
    ]
    
    private let bgImg : UIImageView = {
        let bgImg = UIImageView(image: UIImage(named: "bgChess"))
        bgImg.contentMode = .scaleAspectFill
        bgImg.clipsToBounds = true
        return bgImg
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RowView.self, forCellWithReuseIdentifier: RowView.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgImg)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        if (games == nil) {
            Task {
                do {
                    games = try await AsyncNetworkManager.shared.getUserGames(username: username)
                    games = games!.reversed()
                    collectionView.reloadData()
                } catch {
                    let noResult = NoResultView()
                    view.addSubview(noResult)
                    noResult.frame = view.bounds
                    print("Erreur lors de la récupération des jeux : \(error)")
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgImg.frame = view.bounds
        collectionView.frame = view.safeAreaLayoutGuide.layoutFrame
    }

    func parseGame(game: Game) -> [String: Any] {
        var parsedGame : [String : Any] = [:]
        parsedGame["mode"] = game.mode as String
        parsedGame["url"] = game.url as String
        parsedGame["endTime"] =  parseDate(date: game.endTime) as String
        parsedGame["opponent"] = game.white.username.lowercased() == username.lowercased() ? game.black : game.white
        parsedGame["result"] = game.white.username.lowercased() != username.lowercased() ? score[game.black.result as String] : score[game.white.result as String]
        return parsedGame
    }
    func parseDate(date: Date) -> String {
        return "\(date.formatted(date: .numeric, time: .omitted).prefix(5))"
    }
}

extension GamesHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RowView.identifier, for: indexPath) as? RowView else {return UICollectionViewCell()}
        cell.item = parseGame(game: games![indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (games != nil) {
            return games!.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout ,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
