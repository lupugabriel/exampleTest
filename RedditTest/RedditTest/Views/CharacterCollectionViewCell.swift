//
//  CharacterCollectionViewCell.swift
//  RedditTest
//
//  Created by Gabriel Lupu on 09.06.2022.
//

import UIKit
import AlamofireImage

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!

    var data: CharacterModel? {
        didSet {
            if let data = data {
                nameLabel.text = data.name ?? ""
                statusLabel.text = data.status ?? ""
                speciesLabel.text = data.species ?? ""
                genderLabel.text = data.gender ?? ""
                originLabel.text = data.origin?.name ?? ""
                locationLabel.text = data.location?.name ?? ""
                if let url = URL(string: data.image ?? "") {
                    self.imageView.af_setImage(withURL: url)
                }
            }
        }
    }
}
