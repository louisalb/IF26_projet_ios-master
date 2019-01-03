//
//  PokemonDAO.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 18/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit
import SQLite

class PokemonDAO: DataBaseHelper {

    override init() {
        super.init()
        super.createTables()
    }
    
    func save(pokemon: Pokemon) {
        do{
            try super.dataBase.run(super.POKEMON_TABLE.insert(DataBaseHelper.ID_POKEMON <- pokemon.getId(), DataBaseHelper.NOM_POKEMON <- pokemon.getNom()))
        } catch {
            print("insert pokemon failed : \(error)")
        }
    }
    
    func loadFirstGen() {
        let pokemonNames = ["Bulbizarre", "Herbizarre", "Florizarre", "Salameche", "Reptincel",
                            "Dracaufeu", "Carapuce", "Carabaffe", "Tortank", "Chenipan", "Chrysacier", "Papillusion",
                            "Aspicot", "Coconfort", "Dardargnan", "Roucool", "Roucoups", "Roucarnage", "Rattata",
                            "Rattatac", "Piafabec", "Rapasdepic", "Abo", "Arbok", "Pikachu", "Raichu", "Sabelette",
                            "Sablaireau", "Nidoran♀", "Nidorina", "Nidoqueen", "Nidoran♂", "Nidorino", "Nidoking",
                            "Melofee", "Melodelfe", "Goupix", "Feunard", "Rondoudou", "Grodoudou", "Nosferapti",
                            "Nosferalto", "Mystherbe", "Ortide", "Rafflesia", "Paras", "Parasect", "Mimitoss",
                            "Aeromite", "Taupiqueur", "Triopikeur", "Miaouss", "Persian", "Psykokwak", "Akwakwak",
                            "Ferosinge", "Colossinge", "Caninos", "Arcanin", "Ptitard", "Tetarte", "Tartard",
                            "Abra", "Kadabra", "Alakazam", "Machoc", "Machopeur", "Mackogneur", "Chetiflor",
                            "Boustiflor", "Empiflor", "Tentacool", "Tentacruel", "Racaillou", "Gravalanch", "Grolem",
                            "Ponyta", "Galopa", "Ramoloss", "Flagadoss", "Magneti", "Magneton", "Canarticho",
                            "Doduo", "Dodrio", "Otaria", "Lamantine", "Tadmorv", "Grotadmorv", "Kokiyas", "Crustabri",
                            "Fantominus", "Spectrum", "Ectoplasma", "Onix", "Soporifik", "Hypnomade", "Kraby",
                            "Krabboss", "Voltorbe", "Electrode", "Noeunoeuf", "Noadkoko", "Osselait", "Ossatueur",
                            "Kicklee", "Tygnon", "Excelangue", "Smogo", "Smogogo", "Rhinocorne", "Rhinoferos",
                            "Leveinard", "Saquedeneu", "Kangourex", "Hypotrempe", "Hypocean", "Poissirene", "Poissoroy",
                            "Stari", "Staross", "M. Mime", "Insecateur", "Lippoutou", "Elektek", "Magmar", "Scarabrute",
                            "Tauros", "Magicarpe", "Leviator", "Lokhlass", "Metamorph", "Evoli", "Aquali", "Voltali",
                            "Pyroli", "Porygon", "Amonita", "Amonistar", "Kabuto", "Kabutops", "Ptera", "Ronflex",
                            "Artikodin", "Electhor", "Sulfura", "Minidraco", "Draco", "Dracolosse", "Mewtwo", "Mew"]
        for(index, pokemon) in pokemonNames.enumerated() {
            self.save(pokemon: Pokemon.init(id: index + 1, nom: pokemon))
        }
    }
    
    func getAllPokemon() -> Array<Pokemon> {
        var pokemons: [Pokemon] = []
        do {
            for pokemon in try super.dataBase.prepare(super.POKEMON_TABLE){
                pokemons.append(Pokemon.init(id: pokemon[DataBaseHelper.ID_POKEMON], nom: pokemon[DataBaseHelper.NOM_POKEMON]))
            }
        } catch {
            print("get all pokemon failed : \(error)")
        }
        return pokemons
    }
    
    func getPokemon(id: Int) -> Pokemon? {
        var pokemon: Pokemon
        let query = super.POKEMON_TABLE.filter(DataBaseHelper.ID_POKEMON == id)
        do{
            for row in try super.dataBase.prepare(query) {
                pokemon = Pokemon.init(id: row[DataBaseHelper.ID_POKEMON], nom: row[DataBaseHelper.NOM_POKEMON])
                return pokemon
            }
        } catch {
            print("get pokemon failed : \(error)")
        }
        return nil
    }    
}
