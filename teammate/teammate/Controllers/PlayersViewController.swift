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
        tableView.delegate = self
        tableView.dataSource = self
        // tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerCell")
        
        tableView.register(SquadPlayerViewCell.nib(), forCellReuseIdentifier: SquadPlayerViewCell.identifier)
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

extension PlayersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "playerview")
        vc.navigationItem.title = players[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
        print("cell taped")
    }		
}

extension PlayersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SquadPlayerViewCell", for: indexPath) as! SquadPlayerViewCell
        let player = players[indexPath.row]
        cell.playerName.text = player.name
        cell.imageView?.image = UIImage(systemName: "square.fill")
        // cell.configure(with: player)
        return cell
    }
}

class PlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    func configure(with player: SquadPlayer) {
        self.textLabel?.text = player.name
        nameLabel?.text = player.name
        positionLabel?.text = player.position
    }
}

