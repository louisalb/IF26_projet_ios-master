//
//  Dresseur.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 18/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit

class Dresseur {
    
    private var id: Int
    private var pseudo: String
    private var password: String
    
    init(id: Int, pseudo: String, password: String) {
        self.id = id
        self.pseudo = pseudo
        self.password = password
    }
    
    init(pseudo: String, password: String) {
        self.id = -1
        self.pseudo = pseudo
        self.password = password
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func setId(id: Int) {
        self.id = id
    }
    
    func getPseudo() -> String {
        return self.pseudo
    }
    
    func setPseudo(pseudo: String) {
        self.pseudo = pseudo
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func setPassword(password: String) {
        self.password = password
    }
    
    func toString() -> String {
        return "Dresseur : id -> \(self.id) / pseudo -> \(self.pseudo) / mdp -> \(self.password)"
    }
}
