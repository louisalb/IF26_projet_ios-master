//
//  InscriptionViewController.swift
//  if26_projet_ios
//
//  Created by Louis ALBERT on 02/01/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class InscriptionViewController: UIViewController {

   
    @IBOutlet weak var confmdpInscriptionTextField: UITextField!
    @IBOutlet weak var mdpInscriptionTextField: UITextField!
    @IBOutlet weak var identifiantInscriptionTextField: UITextField!
    @IBOutlet weak var confmdpInscriptionLabel: UILabel!
    @IBOutlet weak var mdpInscriptionLabel: UILabel!
    @IBOutlet weak var identifiantInscriptionLabel: UILabel!
    
  
    var loginSuccess = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func inscrireInscriptionAction(_ sender: UIButton) {
        
        if identifiantInscriptionTextField.text?.isEmpty ?? true {
            identifiantInscriptionLabel.attributedText = self.messageError(msg:"Identifiant :\nVous devez choisir un identifiant",position:13,taille:34)
            super.viewDidLoad()
            
        }
        else {
            let dresseurDAO:DresseurDAO = DresseurDAO()
            let pseudo: String = identifiantInscriptionTextField.text!
            
            if (dresseurDAO.getDresseurByPseudo(pseudo:pseudo) != nil) {
                identifiantInscriptionLabel.attributedText = self.messageError(msg:"Identifiant :\nCe nom d'utilisateur n'est pas disponible",position:13,taille:42)
            }
            else if mdpInscriptionTextField.text?.count ?? 0 < 6 {
                identifiantInscriptionLabel.attributedText = self.messageError(msg:"Identifiant :\nLe mot de passe est trop court : 6 caractères minimum.",position:13,taille:55)
            }
            else if mdpInscriptionTextField.text != confmdpInscriptionTextField.text{
                identifiantInscriptionLabel.attributedText = self.messageError(msg:"Identifiant :\nLa confirmation du mot de passe n'est pas valide.",position:13,taille:50)
            }
            else{
                let mdp:String = mdpInscriptionTextField.text!.sha1!
                dresseurDAO.save(dresseur: Dresseur(pseudo: identifiantInscriptionTextField.text!,password: mdp))
                loginSuccess = true
            }
        }
      
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "inscrireSegue" {
                if loginSuccess != true {
                    return false
                }
                
            }
        }
        return true
    }
    
    func messageError(msg:String, position:Int, taille:Int) -> NSMutableAttributedString{
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: msg, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 17.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:position,length:taille))
        return myMutableString
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inscrireSegue" {
            if let destinationVC = segue.destination as? HomeViewController {
                destinationVC.identifiantLabel =  "Identifiant :\nInscription réussie ! Vous pouvez vous connecter."
            }
        }
    }
    

}
