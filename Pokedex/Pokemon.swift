//
//  Pokemon.swift
//  Pokedex
//
//  Created by Amit Kumar on 26/01/17.
//  Copyright © 2017 Gaana1MB. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    private var _name : String!
    private var _pokedexId : Int!
    private var _description : String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _pokemonURL : String!
    private var _nextEvolId :String!
    private var _nextEvolLevel : String!
    private var _nextEvolName :String!
    
    var nextEvolName:String{
        if _nextEvolName == nil{
            _nextEvolName = ""
        }
        return _nextEvolName
    }
    
    var nextEvolLevel : String{
        if _nextEvolLevel == nil{
            _nextEvolLevel = ""
        }
        return _nextEvolLevel
    }
    
    var nextEvolId :String{
        if _nextEvolId == nil{
            _nextEvolId = ""
        }
        return _nextEvolId
    }
    
    var description : String{
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type :String {
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var attack:String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var weight:String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var height:String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var defense:String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var name: String{
        return _name
    }
    
    var pokedexId : Int{
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetail(completed : @escaping DownloadComplete){
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, Any>{
               
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = String(defense)
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0{
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    if types.count > 1{
                        for x in 1..<types.count{
                            let name = types[x]["name"]
                            self._type! += "/\(name!.capitalized)"
                        }
                    }
                    
                }else{
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>] , descArr.count > 0{
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        let actualUrl = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(actualUrl).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String,Any>{
                                
                                if let description = descDict["description"] as? String{
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemons")
                                    
                                    self._description = newDescription
                                
                                }
                            }
                            completed()
                        })
                    }
                }else{
                   
                    self._description = ""
                
                }
                
                
                if let evolutionArr = dict["evolutions"] as? [Dictionary<String,AnyObject>], evolutionArr.count > 0 {
                    if let nextEvo = evolutionArr[0]["to"] as? String{
                        if nextEvo.range(of: "mega") == nil{
                            self._nextEvolName = nextEvo
                            if let uri = evolutionArr[0]["resource_uri"] as? String {
                                let newEvoId = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newEvoId.replacingOccurrences(of: "/", with: "")
                                self._nextEvolId = nextEvoId
                                
                                if let level = evolutionArr[0]["level"] {
                                    if let lvl = level as? Int{
                                        self._nextEvolLevel = "\(lvl)"
                                        
                                    }
                                }else{
                                    self._nextEvolLevel = ""
                                }
                            }
                            
                        }
                    }
                    print(self._nextEvolName)
                    print(self._nextEvolId)
                    print(self._nextEvolLevel)

                }
                
//                print(self._height)
//                print(self._weight)
//                print(self._attack)
//                print(self._defense)
                
                
            }
            completed()
        }
        
    }
}










