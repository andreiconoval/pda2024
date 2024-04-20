//
//  PlayerViewController.swift
//  teammate
//
//  Created by user256828 on 4/20/24.
//

import UIKit

class PlayerViewController: UIViewController {
    public var playerID: Int!
    private let apiClient = APIClient()
    private var player: Player!
    private var playerMatches: PlayerMatchesResult!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var shirtnumberLabel: UILabel!
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var awayFlag: UIImageView!
    @IBOutlet weak var homeFlag: UIImageView!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var competitionLabel: UILabel!
    @IBOutlet weak var competitionImage: UIImageView!
    @IBOutlet weak var areaCountryLabel: UILabel!
    @IBOutlet weak var areaFlagImage: UIImageView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var matchesView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataView.roundCorners([.allCorners], radius: 20)
        matchesView.roundCorners([.allCorners], radius: 20)
        if playerID != nil
        {
            fetchPlayer()
        }

    }
    
    @IBAction func searchPlayer(_ sender: Any) {
        showWebView()
    }
    
    func fetchPlayer() {
        apiClient.fetchPlayerData(playerID: playerID){ [weak self] result in
            switch result {
            case .success(let player):
                self?.player = player
                DispatchQueue.main.async {
                     self?.updateUI(with: player)
                }
            case .failure(let error):
                print("Failed to fetch players: \(error)")
            }
        }
        
        apiClient.fetchPlayerMatches(playerID: playerID){ [weak self] result in
            switch result {
            case .success(let playerMatches):
                DispatchQueue.main.async {
                    self?.playerMatches = playerMatches
                    if let match = playerMatches.matches?.first
                    {
                        self?.updateCompetitionUI(with: match)
                    }
                }
            case .failure(let error):
                print("Failed to fetch players: \(error)")
            }
        }
    }
    
    func updateCompetitionUI(with match: Match)
    {	
        self.areaCountryLabel?.text = match.area.name
        self.competitionLabel?.text = match.competition.name
        self.homeLabel?.text = match.homeTeam.shortName
        self.awayLabel?.text = match.awayTeam.shortName
        self.winnerLabel?.text = match.score.winner
        self.scoreLabel?.text = "\(String(match.score.fullTime["home"]!)) : \(String(match.score.fullTime["away"]!)) "
        loadImage(urlString: match.area.flag) { image in
                   DispatchQueue.main.async {
                       self.areaFlagImage?.image = image
                   }
               }
        if let emblem = match.competition.emblem
        {
            loadImage(urlString: emblem) { image in
                       DispatchQueue.main.async {
                           self.competitionImage?.image = image
                       }
                   }
        }
       
        loadImage(urlString: match.awayTeam.crest) { image in
                   DispatchQueue.main.async {
                       self.awayFlag?.image = image
                   }
               }
        
        loadImage(urlString: match.homeTeam.crest) { image in
                   DispatchQueue.main.async {
                       self.homeFlag?.image = image
                   }
               }
    }
    
    func updateUI(with player: Player) {
        nameLabel?.text = player.name
        dateOfBirthLabel?.text = player.dateOfBirth
        nationalityLabel?.text = player.nationality
        positionLabel?.text = player.position
        shirtnumberLabel?.text = String(player.shirtNumber)
        let dict = [2819: "198760", 3087: "283948"]

        if let value = dict[player.id] {
            if let imagePath = Bundle.main.path(forResource: value, ofType: "jpg") {
                if let image = UIImage(contentsOfFile: imagePath) {
                    self.profileImageView?.image = image
                }
            }
        } else if player.position == "Goalkeeper"
        {
            self.profileImageView?.image = UIImage(named: "goalie")
        }
        else if player.position == "Defence"
        {
            self.profileImageView?.image = UIImage(named: "defence")
        }
        else if player.position == "Midfield"
        {
            self.profileImageView?.image = UIImage(named: "dribble")
        }
        else if player.position == "Offence"
        {
            self.profileImageView?.image = UIImage(named: "foul")
        }
    }
    
    func showWebView()
    {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let playerViewController = storyboard.instantiateViewController(withIdentifier: "PlayerWebViewController") as! PlayerWebViewController
        playerViewController.SearchName = player.name
        navigationController?.pushViewController(playerViewController, animated: true)
    }
}
