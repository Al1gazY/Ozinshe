//
//  MovieTableViewCell.swift
//  Ozinshe
//
//  Created by Aligazy Kismetov on 30.12.2022.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        posterImageView.layer.cornerRadius = 8
        playView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(movie: Movie) {
        posterImageView.sd_setImage(with: URL(string: movie.poster_link))
        
        nameLabel.text = movie.name
        yearLabel.text = "\(movie.year)"
        
        for item in movie.genres {
            yearLabel.text = yearLabel.text! + " • " + item.name
        }
    }

}
