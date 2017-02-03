//
//  PokeCell.swift
//  Pokedex
//
//  Created by Amit Kumar on 26/01/17.
//  Copyright © 2017 Gaana1MB. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    
    
    
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon :Pokemon){
        self.pokemon = pokemon
        self.nameLbl.text = self.pokemon.name.capitalized
        self.thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    
    
}
