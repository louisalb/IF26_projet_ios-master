//
//  DresseurDAO.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 18/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit
import SQLite

class DresseurDAO: DataBaseHelper {
    
    override init() {
        super.init()
        super.createTables()
    }
    
    func save(dresseur: Dresseur) {
        do {
            try super.dataBase.run(super.DRESSEUR_TABLE.insert(DataBaseHelper.PSEUDO_DRESSEUR <- dresseur.getPseudo(), DataBaseHelper.MOT_DE_PASSE_DRESSEUR <- dresseur.getPassword()))
        } catch {
            print("insert dresseur failed : \(error)")
        }
    }
    
    func getDresseurByPseudo(pseudo: String) -> Dresseur? {
        let query = super.DRESSEUR_TABLE.filter(DataBaseHelper.PSEUDO_DRESSEUR == pseudo)
        let dresseur = self.getDresseur(query: query)
        return dresseur
    }
    
    func getDresseurById(id: Int) -> Dresseur? {
        let query = super.DRESSEUR_TABLE.filter(DataBaseHelper.ID_DRESSEUR == id)
        let dresseur = self.getDresseur(query: query)
        return dresseur
    }
    
    private func getDresseur(query: Table) -> Dresseur? {
        var dresseur: Dresseur
        do {
            for row in try super.dataBase.prepare(query) {
                dresseur = Dresseur.init(id: row[DataBaseHelper.ID_DRESSEUR], pseudo: row[DataBaseHelper.PSEUDO_DRESSEUR], password: row[DataBaseHelper.MOT_DE_PASSE_DRESSEUR])
                return dresseur
            }
        } catch {
            print("get dresseur failed : \(error)")
        }
        return nil
    }
}
