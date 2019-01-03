//
//  Pokemon.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 18/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit

class Pokemon {
    
    private var id: Int
    private var nom: String
    
    init(id: Int, nom: String) {
        self.id = id
        self.nom = nom
    }
    
    func getNom() -> String {
        return self.nom
    }
    
    func setNom(nom: String) {
        self.nom = nom
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func setId(id: Int) {
        self.id = id
    }
    
    func toString() -> String {
        return "Pokemon : id -> \(self.id) / nom -> \(self.nom)"
    }
    
}
