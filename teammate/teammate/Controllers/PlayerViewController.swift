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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var shirtnumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    func updateUI(with player: Player) {
        nameLabel?.text = player.name
        dateOfBirthLabel?.text = player.dateOfBirth
        nationalityLabel?.text = player.nationality
        positionLabel?.text = player.position
        shirtnumberLabel?.text = String(player.shirtNumber)
    }
    
    func showWebView()
    {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let playerViewController = storyboard.instantiateViewController(withIdentifier: "PlayerWebViewController") as! PlayerWebViewController
        playerViewController.SearchName = player.name
        navigationController?.pushViewController(playerViewController, animated: true)
    }
}
