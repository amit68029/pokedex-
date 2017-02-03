//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Amit Kumar on 27/01/17.
//  Copyright © 2017 Gaana1MB. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl : UILabel!
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    @IBOutlet weak var currentImg : UIImageView!
    @IBOutlet weak var nextImg : UIImageView!
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI(){
        self.nameLbl.text = self.pokemon.name.capitalized
        self.mainImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        self.currentImg.image = self.mainImg.image
        self.weightLbl.text = self.pokemon.weight
        self.heightLbl.text = self.pokemon.height
        self.attackLbl.text = self.pokemon.attack
        self.defenceLbl.text = self.pokemon.defense
        self.typeLbl.text = self.pokemon.type
        self.descriptionLbl.text = self.pokemon.description
        
        if pokemon.nextEvolId == ""{
            nextEvolutionLbl.text = "NO next Evolutions"
            nextImg.isHidden = true
        }else{
            nextEvolutionLbl.text = "Next Evolution: \(self.pokemon.nextEvolName)- LVL \(self.pokemon.nextEvolLevel)"
            nextImg.image = UIImage(named : "\(self.pokemon.nextEvolId)")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pokemon.downloadPokemonDetail {
            
            self.updateUI()
        }


    }

 
}
