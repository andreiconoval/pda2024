//
//  MyTeamsTableViewController.swift
//  teammate
//
//  Created by user256828 on 5/22/24.
//

import UIKit

class MyTeamsTableViewController: UITableViewController {

    
    @IBAction func addMyTeam(_ sender: Any) {
        let alert = UIAlertController(title: "Add new team", message: "What is name and image?", preferredStyle: .alert)
        alert.addTextField { UITextField in
            UITextField.placeholder = "Team name"
        }
        
        alert.addTextField { UITextField in
            UITextField.placeholder = "Team image url"
        }
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            let nameTextField = alert.textFields![0]
            let imageTextFiled = alert.textFields![1]
            let newTeam = CDTeam(context: self.context)
            newTeam.name = nameTextField.text
            newTeam.imageURL = imageTextFiled.text
            do {
                
                try self.context.save()
                
            } catch {
                
            }
            self.fetchTeams()
        }
        
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    }
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.teams!.count
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete"){
            (action, view, completionHandler) in
            let teamToRemove = self.teams![indexPath.row]
            self.context.delete(teamToRemove)
            do {
                try self.context.save()
            } catch {
                
            }
            
            self.fetchTeams()
        }
        let updateAction = UIContextualAction(style: .normal, title: "Update"){
            (action, view, completionHandler) in
            let teamToUpdate = self.teams![indexPath.row]

            let alert = UIAlertController(title: "Update team", message: "Change is name and image", preferredStyle: .alert)
            alert.addTextField { UITextField in
                UITextField.placeholder = "Team name"
            }
            
            alert.addTextField { UITextField in
                UITextField.placeholder = "Team image url"
            }
            
            let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
                let nameTextField = alert.textFields![0]
                let imageTextFiled = alert.textFields![1]
                let newTeam = CDTeam(context: self.context)
                newTeam.name = nameTextField.text
                newTeam.imageURL = imageTextFiled.text
                do {
                    
                    try self.context.save()
                    
                } catch {
                    
                }
                self.fetchTeams()
            }
            
            alert.addAction(submitButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        return UISwipeActionsConfiguration(actions: [updateAction,action])
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTeamCell", for: indexPath)

        cell.textLabel?.text = self.teams?[indexPath.row].name
        
        return cell
    }


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
