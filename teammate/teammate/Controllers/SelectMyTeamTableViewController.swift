//
//  SelectMyTeamTableViewController.swift
//  teammate
//
//  Created by user256828 on 5/23/24.
//

import UIKit
import CoreData
class SelectMyTeamTableViewController: UITableViewController {

    public var player: SquadPlayer!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var teams: [CDTeam]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchTeams()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fetchTeams()
    {
        do
        {
            self.teams = try  context.fetch(CDTeam.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
        catch {
            
        }
    }

    // MARK: - Table view data source

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       do {
           let request = CDPlayer.fetchRequest() as NSFetchRequest<CDPlayer>
           let playerId = Int16(player.id)
           let pred = NSPredicate(format: "id == %d", playerId)
           
           request.predicate = pred
           let players = try context.fetch(request)
           
           if(players.count > 0)
           {
               if(players[0].team == self.teams![indexPath.row])
               {
                   do {
                       
                       try self.context.save()
                       showToast(message: "\(player.name) already in your team \(self.teams![indexPath.row].name)", font: .systemFont(ofSize: 12.0))
                       
                   } catch {
                       
                   }
               }
               else {
                   self.teams![indexPath.row].addToPlayer(players[0])
                   do {
                       
                       try self.context.save()
                       showToast(message: "\(player.name) moved to your team \(self.teams![indexPath.row].name)", font: .systemFont(ofSize: 12.0))
                       
                   } catch {
                       
                   }
               }
           } else
           {
               let newPlayer = CDPlayer(context: self.context)
               newPlayer.id = Int16(player.id)
               newPlayer.name = player.name
               newPlayer.nationality = player.nationality
               newPlayer.position = player.position
               
               self.teams![indexPath.row].addToPlayer(newPlayer)
               do {
                   
                   try self.context.save()
                   showToast(message: "\(player.name) add to your team \(self.teams![indexPath.row].name)", font: .systemFont(ofSize: 12.0))
                   
               } catch {
                   
               }
           }
           

         
       }
       catch {
           
       }
       
       
       
       // self.navigationController?.showDetailViewController(teamController, sender: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.teams!.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTeamCell", for: indexPath)

        cell.textLabel?.text = self.teams?[indexPath.row].name
        
        return cell
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
