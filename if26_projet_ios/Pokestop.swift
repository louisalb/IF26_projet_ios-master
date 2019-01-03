//
//  Pokestop.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 18/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit

class Pokestop {
    
    private var id: Int
    private var is_gym: Bool
    private var latitude: Double
    private var longitude: Double
    private var dresseur: Dresseur
    private var nom: String
    
    init(id: Int, is_gym: Bool, latitude: Double, longitude: Double, dresseur: Dresseur, nom: String) {
        self.id = id
        self.is_gym = is_gym
        self.latitude = latitude
        self.longitude = longitude
        self.dresseur = dresseur
        self.nom = nom
    }
    
    init(is_gym: Bool, latitude: Double, longitude: Double, dresseur: Dresseur, nom: String) {
        self.id = -1
        self.is_gym = is_gym
        self.latitude = latitude
        self.longitude = longitude
        self.dresseur = dresseur
        self.nom = nom
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func setId(id: Int) {
        self.id = id
    }
    
    func getIs_gym() -> Bool {
        return self.is_gym
    }
    
    func setIs_gym(is_gym: Bool) {
        self.is_gym = is_gym
    }
    
    func getLatitude() -> Double {
        return self.latitude
    }
    
    func setLatitude(latitude: Double) {
        self.latitude = latitude
    }
    
    func getLongitude() -> Double {
        return self.longitude
    }
    
    func setLongitude(longitude: Double) {
        self.longitude = longitude
    }
    
    func getDresseur() -> Dresseur {
        return self.dresseur
    }
    
    func setDresseur(dresseur: Dresseur) {
        self.dresseur = dresseur
    }
    
    func getNom() -> String {
        return self.nom
    }
    
    func setNom(nom: String) {
        self.nom = nom
    }

    func toString() -> String {
        return "Pokestop : id -> \(self.id) / nom -> \(self.nom) / is_gym -> \(self.is_gym) / latitude -> \(self.latitude) / longitude -> \(self.longitude) / dresseur -> {\(self.dresseur.toString())}"
    }
}
