//
//  TeamItemViewCell.swift
//  teammate
//
//  Created by user256828 on 4/20/24.
//

import UIKit

class TeamItemViewCell: UITableViewCell {

    @IBOutlet weak var crestImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    
    static let identifier = "TeamItemViewCell"
    static func nib() -> UINib {
        return UINib(nibName:"TeamItemViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(name: String , image: UIImage) {
        self.nameLable?.text = name
        self.crestImage?.image = image
    }
}
