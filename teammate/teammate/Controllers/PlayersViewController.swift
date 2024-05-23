//
//  PlayersViewController.swift
//  teammate
//
//  Created by user256828 on 4/18/24.
//

import UIKit

class PlayersViewController: UIViewController {
    
    var teamID: Int!
    
    @IBOutlet weak var tableView: UITableView!
    private let apiClient = APIClient()
    private var players: [SquadPlayer] = []
    private var team: Team!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var crestImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerCell")
        
        tableView.register(SquadPlayerViewCell.nib(), forCellReuseIdentifier: SquadPlayerViewCell.identifier)
        fetchPlayers()
    }
    
    func updateUI(with team: Team) {
        self.title =  team.shortName
        nameLabel?.text = team.name
        countryLabel?.text = team.area?.name
        venueLabel?.text = team.venue
        addressLabel?.text = team.address
        loadTeamCrest(urlString: team.crest)
        
    }
    
    func fetchPlayers() {
        apiClient.fetchTeamData(teamID:teamID){ [weak self] result in
            switch result {
            case .success(let team):
                self?.players = team.squad
                self?.team = team
                DispatchQueue.main.async {
                    self?.updateUI(with: team)
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch players: \(error)")
                DispatchQueue.main.async {
                    self?.nameLabel?.text = "Failed to fetch players"
                    self?.countryLabel?.text = "\(error)"
                    self?.venueLabel?.text = "Try another team"
                    self?.addressLabel?.text = "please!"
                }
            }
        }
    }
    
    func loadTeamCrest(urlString: String) {
        // URL of the image
               // Create URL object from string
               if let url = URL(string: urlString) {
                   // Create a data task to fetch the image
                   URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                       // Check for errors
                       if let error = error {
                           print("Error fetching image: \(error)")
                           return
                       }
                       
                       // Check for response status code
                       guard let httpResponse = response as? HTTPURLResponse,
                             (200...299).contains(httpResponse.statusCode) else {
                           print("Invalid response")
                           return
                       }
                       
                       // Check if data is available
                       if let data = data {
                           // Create image from data
                           if let image = UIImage(data: data) {
                               // Update UI on main thread
                               DispatchQueue.main.async {
                                   self?.crestImage.image = image
                               }
                           }
                       }
                   }.resume() // Resume the data task
               }
    }
}



extension PlayersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let playersController = storyboard.instantiateViewController(withIdentifier: "playerview") as! PlayerViewController
        playersController.title = players[indexPath.row].name
        playersController.playerID = players[indexPath.row].id
        self.navigationController?.pushViewController(playersController, animated: true)
        print("cell taped \(players[indexPath.row].id)")
    }
}

extension PlayersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SquadPlayerViewCell", for: indexPath) as! SquadPlayerViewCell
        let player = players[indexPath.row]
        cell.configure(player: player)
        return cell
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let updateAction = UIContextualAction(style: .normal, title: "Add to my team"){
            (action, view, completionHandler) in
            let player = self.players[indexPath.row]

            let storyboard = UIStoryboard(name: "Main", bundle:nil)
            let teamController = storyboard.instantiateViewController(withIdentifier: "selectTeamTable") as! SelectMyTeamTableViewController
           
            teamController.player = self.players[indexPath.row]
            self.navigationController?.showDetailViewController(teamController, sender: nil)
        }
        return UISwipeActionsConfiguration(actions: [updateAction])
    }
}
