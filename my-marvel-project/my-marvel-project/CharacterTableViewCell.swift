//
//  CharacterTableViewCell.swift
//  my-marvel-project
//
//  Created by Alexandre Gabassi on 08/08/18.
//  Copyright © 2018 Alexandre Gabassi. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var viewShadow: UIView!
    
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameCharacter.text = "Ironman"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
