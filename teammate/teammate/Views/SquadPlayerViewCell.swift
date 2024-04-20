//
//  SquadPlayerViewCell.swift
//  teammate
//
//  Created by user256828 on 4/19/24.
//

import UIKit

class SquadPlayerViewCell: UITableViewCell {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    
    static let identifier = "SquadPlayerViewCell"
    static func nib() -> UINib {
        return UINib(nibName:"SquadPlayerViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(player: SquadPlayer) {
        self.playerName.text = player.name
        if player.position == "Goalkeeper"
        {
            self.imageView?.image = UIImage(named: "goalkeeper-50")
        }
        else
        {
            self.imageView?.image = UIImage(systemName: "figure.soccer")
        }
    }
}
