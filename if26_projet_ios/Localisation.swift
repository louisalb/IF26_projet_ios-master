//
//  Localisation.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 18/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit

class Localisation {

    private var id: Int
    private var time: String
    private var pokestop: Pokestop
    private var pokemon: Pokemon
    private var dresseur: Dresseur
    
    init(id: Int, time: String, pokestop: Pokestop, pokemon: Pokemon, dresseur: Dresseur) {
        self.id = id
        self.pokemon = pokemon
        self.pokestop = pokestop
        self.dresseur = dresseur
        self.time = time
    }
    
    init(time: String, pokestop: Pokestop, pokemon: Pokemon, dresseur: Dresseur) {
        self.id = -1
        self.pokemon = pokemon
        self.pokestop = pokestop
        self.dresseur = dresseur
        self.time = time
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func setId(id: Int) {
        self.id = id
    }
    
    func getTime() -> String {
        return self.time
    }
    
    func setTime(time: String) {
        self.time = time 
    }
    
    func getDresseur() -> Dresseur {
        return self.dresseur
    }
    
    func setDresseur(dresseur: Dresseur) {
        self.dresseur = dresseur
    }
    
    func getPokestop() -> Pokestop {
        return self.pokestop
    }
    
    func setPokestop(pokestop: Pokestop) {
        self.pokestop = pokestop
    }
    
    func getPokemon() -> Pokemon {
        return self.pokemon
    }
    
    func setPokemon(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    func toString() -> String {
        return "Localisation : id -> \(self.id) / time -> \(self.time) / pokestop -> {\(self.pokestop.toString())} / dresseur -> {\(self.dresseur.toString())} / pokemon -> {\(self.pokemon.toString())}"
    }
}
