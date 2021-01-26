//
//  RouletteableTableViewCell.swift
//  Daily
//
//  Created by Marcio Alico on 1/26/21.
//

import UIKit

class RouletteableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
