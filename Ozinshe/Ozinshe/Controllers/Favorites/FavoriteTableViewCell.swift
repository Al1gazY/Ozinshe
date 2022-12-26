//
//  FavoriteTableViewCell.swift
//  Ozinshe
//
//  Created by Aligazy Kismetov on 18.12.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.layer.cornerRadius = 8
        playView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(image: String){
        posterImageView.image = UIImage(named: image)
        
        nameLabel.text = "Айдар"
        yearLabel.text = "2020 • Телехикая • Мультфильм"
    }
}
