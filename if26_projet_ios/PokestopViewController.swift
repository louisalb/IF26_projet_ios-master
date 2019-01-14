//
//  PokestopViewController.swift
//  if26_projet_ios
//
//  Created by Louis ALBERT on 06/01/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class PokestopViewController: UIViewController {
    var latitude:Double = Double()
    var longitude:Double = Double()
    var token = true
    var pokestop:Pokestop?
    
    @IBOutlet weak var nomPokestopLabel: UILabel!
    
    @IBOutlet weak var supprimerPokestopButton: UIButton!
    @IBOutlet weak var modifierPokestopButton: UIButton!
    
    @IBOutlet weak var validerPokestopButton: UIButton!
    @IBOutlet weak var nomPokestopTextField: UITextField!
    @IBOutlet weak var latitudePokestopLabel: UILabel!
    @IBOutlet weak var longitudePokestopLabel: UILabel!
    @IBOutlet weak var switchPokestop: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        if self.token  == true {
            self.latitudePokestopLabel.text = String(self.latitude)
            self.longitudePokestopLabel.text = String(self.longitude)
            self.supprimerPokestopButton.isHidden = true
            self.modifierPokestopButton.isHidden = true
        }
        else{
            self.latitudePokestopLabel.text = String(self.pokestop!.getLatitude())
            self.longitudePokestopLabel.text = String(self.pokestop!.getLongitude())
            self.nomPokestopTextField.text = self.pokestop!.getNom()
            self.validerPokestopButton.isHidden = true
            if self.pokestop?.getIs_gym() == true {
                self.switchPokestop.setOn(true, animated: false)
            }
        }
    }
    
    @IBAction func valider(_ sender: UIButton) {
        if nomPokestopTextField.text?.isEmpty ?? true {
            nomPokestopLabel.attributedText = self.messageError(msg:"Identifiant :\nVous devez choisir un nom de pokestop",position:13,taille:38)
        }
        else{
            let defaults = UserDefaults.standard
            let savedPseudo:String = defaults.object(forKey: "Session en cours") as? String ?? ""
            let dresseurDAO:DresseurDAO = DresseurDAO()
            let dresseur: Dresseur = dresseurDAO.getDresseurByPseudo(pseudo: savedPseudo)!
            let pokestopDAO:PokestopDAO = PokestopDAO()
            let pokestop:Pokestop = Pokestop(is_gym: self.switchPokestop.isOn, latitude: self.latitude, longitude: self.longitude, dresseur: dresseur, nom: nomPokestopTextField.text!)
            pokestopDAO.save(pokestop: pokestop)
            self.performSegue(withIdentifier: "pokestopSegue", sender: nil)
        }
    }
    
    @IBAction func supprimer(_ sender: UIButton) {
        let pokestopDAO:PokestopDAO = PokestopDAO()
        pokestopDAO.deletePokestop(id: (self.pokestop?.getId())!)
        self.performSegue(withIdentifier: "pokestopSegue", sender: nil)
    }
    
    @IBAction func modifier(_ sender: UIButton) {
        let pokestopDAO:PokestopDAO = PokestopDAO()
        self.pokestop?.setNom(nom: self.nomPokestopTextField.text!)
        self.pokestop?.setIs_gym(is_gym: self.switchPokestop.isOn)
        pokestopDAO.update(pokestop: self.pokestop!)
        self.performSegue(withIdentifier: "pokestopSegue", sender: nil)
        
    }
    
    func messageError(msg:String, position:Int, taille:Int) -> NSMutableAttributedString{
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: msg, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 17.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:position,length:taille))
        return myMutableString
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
