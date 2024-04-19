//
//  ViewController.swift
//  teammate
//
//  Created by user256828 on 4/18/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showTeam(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondController = storyboard.instantiateViewController(withIdentifier: "playersViewController")
        secondController.loadViewIfNeeded()
        self.present(secondController, animated: true, completion: nil)
    }
    
}

