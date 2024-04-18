//
//  PlayersViewController.swift
//  teammate
//
//  Created by user256828 on 4/18/24.
//

import UIKit

class PlayersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let apiClient = APIClient()
    private var players: [SquadPlayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlayers()
    }
    
    func fetchPlayers() {
        apiClient.fetchTeamData(teamID:90){ [weak self] result in
            switch result {
            case .success(let team):
                self?.players = team.squad
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch players: \(error)")
            }
        }
    }
}

extension PlayersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell
        let player = players[indexPath.row]
        cell.configure(with: player)
        return cell
    }
}

class PlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    func configure(with player: SquadPlayer) {
        nameLabel.text = player.name
        positionLabel.text = player.position
    }
}

