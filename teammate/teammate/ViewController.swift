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
        loadImage(urlString: urlString) { [weak cell] image in
                   DispatchQueue.main.async {
                       cell?.crestImage?.image = image
                   }
               }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
   
}

