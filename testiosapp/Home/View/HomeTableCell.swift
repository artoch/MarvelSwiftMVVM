//
//  HomeTableCell.swift
//  testiosapp
//
//  Created by Alfredo Tochon on 11/10/20.
//

import UIKit

class HomeTableCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var ivTitle: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ character:Character){
        if character.description.isEmpty{
            self.labelDescription.text = "Sin descripción"
        }else{
            self.labelDescription.text = character.description
        }
        labelName.text = character.name
        ivTitle.imageFromServerURL(url: "\(character.thumbnail.path)/portrait_xlarge.\(character.thumbnail.ext)", placeHolderImage: UIImage(named: "genericcomic")!)
    }

}
