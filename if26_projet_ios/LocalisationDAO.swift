//
//  LocalisationDAO.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 18/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit
import SQLite

class LocalisationDAO: DataBaseHelper {

    override init() {
        super.init()
        super.createTables()
    }
    
    func save(localisation: Localisation) {
        do{
            try super.dataBase.run(super.LOCALISATION_TABLE.insert(DataBaseHelper.TIME_LOCALISATION <- localisation.getTime(), DataBaseHelper.ID_POKEMON_LOCALISATION <- localisation.getPokemon().getId(), DataBaseHelper.ID_DRESSEUR_LOCALISATION <- localisation.getDresseur().getId(), DataBaseHelper.ID_POKESTOP_LOCALISATION <- localisation.getPokestop().getId()))
        } catch{
            print("insert localisation failed : \(error)")
        }
    }
    
    func getLocalisations(pokestop_id: Int) -> Array<Localisation> {
        var localisations: [Localisation] = []
        do{
            for localisation in try super.dataBase.prepare(super.LOCALISATION_TABLE){
                let dresseurDAO = DresseurDAO.init()
                let pokestopDAO = PokestopDAO.init()
                let pokemonDAO = PokemonDAO.init()
                let dresseur = dresseurDAO.getDresseurById(id: localisation[DataBaseHelper.ID_DRESSEUR_LOCALISATION])
                let pokemon = pokemonDAO.getPokemon(id: localisation[DataBaseHelper.ID_POKEMON_LOCALISATION])
                let pokestop = pokestopDAO.getPokestop(id: localisation[DataBaseHelper.ID_POKESTOP_LOCALISATION])
                localisations.append(Localisation.init(id: localisation[DataBaseHelper.ID_LOCALISATION], time: localisation[DataBaseHelper.TIME_LOCALISATION], pokestop: pokestop!, pokemon: pokemon!, dresseur: dresseur!))                
            }
        }catch{
            print("get all localisations failed : \(error)")
        }
        return localisations
    }
    
    func delete(id: Int) {
        let localisation = super.LOCALISATION_TABLE.filter(DataBaseHelper.ID_LOCALISATION == id)
        do{
            try super.dataBase.run(localisation.delete())
        } catch {
            print("delete localisation failed : \(error)")
        }
    }
}
