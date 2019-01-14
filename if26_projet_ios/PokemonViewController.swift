//
//  PokemonViewController.swift
//  if26_projet_ios
//
//  Created by Louis ALBERT on 07/01/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController{
    
    
    @IBOutlet weak var editPokestopBtn: UIButton!
    @IBOutlet weak var stackViewScrollView: UIStackView!
    @IBOutlet weak var pokemonStackView: UIStackView!
    @IBOutlet weak var pokemonLabelStackView: UILabel!
    @IBOutlet weak var pseudoPokemonLabel: UILabel!
    var nomPokestop:String = String()
    var pokestop:Pokestop? = nil
    var pokemonId:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pseudoPokemonLabel.text = self.nomPokestop
        let pokemonDAO:PokemonDAO = PokemonDAO()
        let pokemon:Pokemon = pokemonDAO.getPokemon(id: self.pokemonId)!
        self.pokemonLabelStackView.text = "#\(self.pokemonId) \(pokemon.getNom())"
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.afficherPokemonPicker(_:)))
        self.pokemonStackView.addGestureRecognizer(gesture)
        let localisationDAO:LocalisationDAO = LocalisationDAO()
        let pokestopDAO:PokestopDAO = PokestopDAO()
        self.pokestop = pokestopDAO.getPokestopByNom(nom: self.nomPokestop)
        let localisationArray:[Localisation] = localisationDAO.getLocalisations(pokestop_id: ((self.pokestop?.getId())!))
        for localisation in localisationArray{
            self.ajouterLignePokemon(nom: localisation.getPokemon().getNom(), date: localisation.getTime(), localisationId: localisation.getId())
        }
        let defaults = UserDefaults.standard
        let savedPseudo:String = defaults.object(forKey: "Session en cours") as? String ?? ""
        if(self.pokestop?.getDresseur().getPseudo() != savedPseudo){
            self.editPokestopBtn.isHidden = true
        }
       
    }
    
    @IBAction func ajouter(_ sender: UIButton) {
        let pokemonDAO:PokemonDAO = PokemonDAO()
        let pokemon:Pokemon = pokemonDAO.getPokemon(id: self.pokemonId)!
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let dateString = "Le \(day)/\(month)/\(year) à \(hour):\(minute)"
        let localisationDAO:LocalisationDAO = LocalisationDAO()
        let localisations : [Localisation] = localisationDAO.getLocalisations(pokestop_id:(self.pokestop?.getId())!)
        let defaults = UserDefaults.standard
        let savedPseudo:String = defaults.object(forKey: "Session en cours") as? String ?? ""
        let dresseurDAO:DresseurDAO = DresseurDAO()
        let localisationId:Int
        if localisations.count > 0 {
            localisationId = localisations[localisations.count-1].getId()+1
            let localisation = Localisation(id:localisationId,time: dateString, pokestop: self.pokestop!, pokemon: pokemon, dresseur: dresseurDAO.getDresseurByPseudo(pseudo: savedPseudo)!)
            localisationDAO.save(localisation: localisation)
            self.ajouterLignePokemon(nom: pokemon.getNom(), date: dateString, localisationId: localisation.getId())
        }
        else{
            let localisation = Localisation(time: dateString, pokestop: self.pokestop!, pokemon: pokemon, dresseur: dresseurDAO.getDresseurByPseudo(pseudo: savedPseudo)!)
            localisationDAO.save(localisation: localisation)
            let localisationDAO2 : LocalisationDAO = LocalisationDAO()
            self.ajouterLignePokemon(nom: pokemon.getNom(), date: dateString, localisationId: localisationDAO2.getLocalisations(pokestop_id: (self.pokestop?.getId())!)[0].getId())
        }
    }
    
    func ajouterLignePokemon(nom:String, date:String, localisationId:Int){
        let contentView = UIStackView()
        contentView.axis = .horizontal
        contentView.distribution = .fillProportionally
        contentView.alignment = .fill
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let label1 = UILabel()
        label1.font = label1.font.withSize(16)
        label1.textColor = .gray
        label1.text = nom
        let label2 = UILabel()
        label2.font = label2.font.withSize(16)
        label2.text = date
        label2.textColor = .gray
        let btn = UIButtonCustom()
        btn.localisationId = localisationId
        btn.stackView = contentView
        btn.setTitle("Supprimer", for: .normal)
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        btn.setTitleColor(.blue, for: .normal)
        contentView.addArrangedSubview(label1)
        contentView.addArrangedSubview(label2)
        contentView.addArrangedSubview(btn)
        self.stackViewScrollView.addArrangedSubview(contentView)
        contentView.trailingAnchor.constraint(equalTo:     self.stackViewScrollView.trailingAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo:     self.stackViewScrollView.leadingAnchor, constant: 0).isActive = true
        if(self.stackViewScrollView.arrangedSubviews.count != 1){
            contentView.topAnchor.constraint(equalTo: self.stackViewScrollView.arrangedSubviews[self.stackViewScrollView.arrangedSubviews.count-2].bottomAnchor, constant: 0).isActive = true
        }
    }
    @objc func buttonAction(sender: UIButtonCustom!) {
        sender.stackView.isHidden = true
        sender.stackView.setNeedsDisplay()
        let alert = UIAlertController(title: "Suppression d'un pokemon", message: "Voulez-vous supprimer ce Pokemon ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ANNULER", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            sender.stackView.isHidden = false
        }))
        
        alert.addAction(UIAlertAction(title: "OUI", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            let localisationDAO:LocalisationDAO = LocalisationDAO()
            localisationDAO.delete(id: sender.localisationId)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func afficherPokemonPicker(_ sender:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "tableViewSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableViewSegue" {
            if let destinationVC = segue.destination as? PokemonsTableViewController {
                destinationVC.nomPokestop = self.nomPokestop
            }
        }
        if segue.identifier == "editPokestopSegue" {
            if let destinationVC = segue.destination as? PokestopViewController {
                destinationVC.token = false
                destinationVC.pokestop = self.pokestop
            }
        }
    }
}
