//
//  PokemonsTableViewController.swift
//  if26_projet_ios
//
//  Created by Louis ALBERT on 12/01/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class PokemonsTableViewController: UITableViewController {

    var pokemonId:Int = Int()
    var pickerData:[String] = []
    var nomPokestop:String = String()
    let identifiantModuleCellule = "celluleModule"
    override func viewDidLoad() {
        super.viewDidLoad()
        let pokemonDAO:PokemonDAO = PokemonDAO()
        let pokemonArray:[Pokemon] = pokemonDAO.getAllPokemon()
        for pokemon in pokemonArray {
            self.pickerData.append("#\(pokemon.getId()) \(pokemon.getNom())")
        }
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.pickerData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiantModuleCellule, for: indexPath)
        cell.textLabel?.text = (self.pickerData[indexPath.item])

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pokemonId = indexPath.row + 1
        self.performSegue(withIdentifier: "pokemonViewControllerSegue", sender: self)
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonViewControllerSegue" {
            if let destinationVC = segue.destination as? PokemonViewController {
                destinationVC.pokemonId = self.pokemonId
                destinationVC.nomPokestop = self.nomPokestop
            }
        }
    }
}
