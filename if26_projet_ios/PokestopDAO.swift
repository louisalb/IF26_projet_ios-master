//
//  PokestopDAO.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 18/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit
import SQLite

class PokestopDAO: DataBaseHelper {

    override init() {
        super.init()
        super.createTables()
    }
    
    func save(pokestop: Pokestop) {
        do{
            try super.dataBase.run(super.POKESTOP_TABLE.insert(DataBaseHelper.NOM_POKESTOP <- pokestop.getNom(), DataBaseHelper.IS_GYM_POKESTOP <- pokestop.getIs_gym(),
                                                           DataBaseHelper.LATITUDE_POKESTOP <- pokestop.getLatitude(), DataBaseHelper.LONGITUDE_POKESTOP <- pokestop.getLongitude(),
                                                           DataBaseHelper.ID_DRESSEUR_POKESTOP <- pokestop.getDresseur().getId()))
        } catch {
            print("insert pokestop failed : \(error)")
        }
    }
    
    func getAllPokestop() -> Array<Pokestop> {
        var pokestops: [Pokestop] = []
        do {
            for pokestop in try super.dataBase.prepare(super.POKESTOP_TABLE){
                let dresseurDAO = DresseurDAO.init()
                let dresseur = dresseurDAO.getDresseurById(id: pokestop[DataBaseHelper.ID_DRESSEUR_POKESTOP])
                pokestops.append(Pokestop.init(id: pokestop[DataBaseHelper.ID_POKESTOP], is_gym: pokestop[DataBaseHelper.IS_GYM_POKESTOP], latitude: pokestop[DataBaseHelper.LATITUDE_POKESTOP], longitude: pokestop[DataBaseHelper.LONGITUDE_POKESTOP], dresseur: dresseur!, nom: pokestop[DataBaseHelper.NOM_POKESTOP]))
            }
        }catch{
            print("get all pokestop failed : \(error)")
        }
        return pokestops
    }
    
    func update(pokestop: Pokestop) {
        let updatedPokestop = super.POKESTOP_TABLE.filter(DataBaseHelper.ID_POKESTOP == pokestop.getId())
        do {
            try super.dataBase.run(updatedPokestop.update(DataBaseHelper.NOM_POKESTOP <- pokestop.getNom(), DataBaseHelper.IS_GYM_POKESTOP <- pokestop.getIs_gym(),
                                                          DataBaseHelper.LATITUDE_POKESTOP <- pokestop.getLatitude(), DataBaseHelper.LONGITUDE_POKESTOP <- pokestop.getLongitude(),
                                                          DataBaseHelper.ID_DRESSEUR_POKESTOP <- pokestop.getDresseur().getId()))
        } catch {
            print("update pokestop failed : \(error)")
        }
    }
    
    func getPokestop(id: Int) -> Pokestop? {
        var pokestop: Pokestop
        let query = super.POKESTOP_TABLE.filter(DataBaseHelper.ID_POKESTOP == id)
        do{
            for row in try super.dataBase.prepare(query){
                let dresseurDAO = DresseurDAO.init()
                let dresseur = dresseurDAO.getDresseurById(id: row[DataBaseHelper.ID_DRESSEUR_POKESTOP])
                pokestop = Pokestop.init(id: row[DataBaseHelper.ID_POKESTOP], is_gym: row[DataBaseHelper.IS_GYM_POKESTOP], latitude: row[DataBaseHelper.LATITUDE_POKESTOP], longitude: row[DataBaseHelper.LONGITUDE_POKESTOP], dresseur: dresseur!, nom: row[DataBaseHelper.NOM_POKESTOP])
                return pokestop
            }
        }catch {
            print("get pokestop failed : \(error)")
        }
        return nil
    }
    
    func getPokestopByNom(nom: String) -> Pokestop? {
        var pokestop: Pokestop
        let query = super.POKESTOP_TABLE.filter(DataBaseHelper.NOM_POKESTOP == nom)
        do{
            for row in try super.dataBase.prepare(query){
                let dresseurDAO = DresseurDAO.init()
                let dresseur = dresseurDAO.getDresseurById(id: row[DataBaseHelper.ID_DRESSEUR_POKESTOP])
                pokestop = Pokestop.init(id: row[DataBaseHelper.ID_POKESTOP], is_gym: row[DataBaseHelper.IS_GYM_POKESTOP], latitude: row[DataBaseHelper.LATITUDE_POKESTOP], longitude: row[DataBaseHelper.LONGITUDE_POKESTOP], dresseur: dresseur!, nom: row[DataBaseHelper.NOM_POKESTOP])
                return pokestop
            }
        }catch {
            print("get pokestop failed : \(error)")
        }
        return nil
    }
    
    func deletePokestop(id: Int) {
        let deletedPokestop = super.POKESTOP_TABLE.filter(DataBaseHelper.ID_POKESTOP == id)
        do{
            try super.dataBase.run(deletedPokestop.delete())
        } catch {
            print("delete pokestop failed : \(error)")
        }
    }
}
