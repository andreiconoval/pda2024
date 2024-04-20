//
//  ViewController.swift
//  teammate
//
//  Created by user256828 on 4/18/24.
//

import UIKit

class ViewController: UIViewController {

    let teamParser: TeamParser = TeamParser()
    
    var teams: [TeamItem] = []
    
    @IBOutlet weak var teamsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamsTable.delegate = self
        teamsTable.dataSource = self
        teamsTable.register(TeamItemViewCell.nib(), forCellReuseIdentifier: TeamItemViewCell.identifier)

        fetchTeams()
    }

    func fetchTeams()
    {
        if let parsedTeams = teamParser.parseXML() {
            self.teams = parsedTeams
            self.teamsTable.reloadData()
        } else {
            print("Failed to load XML file.")
        }
    }
    
    @IBAction func showTeam(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playersController = storyboard.instantiateViewController(withIdentifier: "playersViewController") as! PlayersViewController
        self.navigationController?.pushViewController(playersController, animated: true)
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let storyboard = UIStoryboard(name: "Main", bundle:nil)
        //let playersController = storyboard.instantiateViewController(withIdentifier: "playerview") as! PlayerViewController
        //playersController.title = players[indexPath.row].name
        //playersController.playerID = players[indexPath.row].id
        //self.navigationController?.pushViewController(playersController, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playersController = storyboard.instantiateViewController(withIdentifier: "playersViewController") as! PlayersViewController
        playersController.teamID = Int(teams[indexPath.row].id)
        self.navigationController?.pushViewController(playersController, animated: true)
        print("cell taped")
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamItemViewCell.identifier, for: indexPath) as! TeamItemViewCell
        let team = teams[indexPath.row]
        cell.nameLable?.text = team.name
        let urlString = team.crest
               loadTeamCrest(urlString: urlString) { [weak cell] image in
                   DispatchQueue.main.async {
                       cell?.crestImage?.image = image
                   }
               }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func loadTeamCrest(urlString: String, completion: @escaping (UIImage?) -> Void) {
            // Create URL object from string
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            // Create a data task to fetch the image
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Check for errors
                if let error = error {
                    print("Error fetching image: \(error)")
                    completion(nil)
                    return
                }
                
                // Check for response status code
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    completion(nil)
                    return
                }
                
                // Check if data is available
                if let data = data {
                    // Create image from data
                    if let image = UIImage(data: data) {
                        // Pass image to completion handler
                        completion(image)
                    }
                }
            }.resume() // Resume the data task
        }
}

