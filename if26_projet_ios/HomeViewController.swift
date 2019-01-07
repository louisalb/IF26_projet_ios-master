//
//  HomeViewController.swift
//  if26_projet_ios
//
//  Created by Louis ALBERT on 03/01/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import CoreLocation
class HomeViewController: UIViewController {
    
    var identifiantLabel:String  = "Identifiant :"
    var pseudo:String = String()
    let defaults = UserDefaults.standard
    var loginSuccess:Bool = false
    @IBOutlet weak var identifiantConnexionLabel: UILabel!
    @IBOutlet weak var mdpConnexionTextField: UITextField!
    @IBOutlet weak var identifiantConnexionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        identifiantConnexionTextField.text = pseudo
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: identifiantLabel, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 17.0)!])
        
        if identifiantLabel == "Identifiant :\nInscription réussie ! Vous pouvez vous connecter."{
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location:13,length:50))
        }
        identifiantConnexionLabel.attributedText = myMutableString
    }
    
    @IBAction func connexion(_ sender: UIButton)  {
        let dresseurDAO:DresseurDAO = DresseurDAO()
        if !((identifiantConnexionTextField.text!.isEmpty ) || (mdpConnexionTextField.text!.isEmpty )) {
            if((dresseurDAO.getDresseurByPseudo(pseudo: identifiantConnexionTextField.text!)) != nil){
                if(dresseurDAO.getDresseurByPseudo(pseudo: identifiantConnexionTextField.text!)!.getPassword() == mdpConnexionTextField.text!.sha1!){
                    self.loginSuccess = true
                    self.pseudo =  (dresseurDAO.getDresseurByPseudo(pseudo: identifiantConnexionTextField.text!)!.getPseudo())
                    defaults.set(pseudo, forKey: "Session en cours")
                }
            }
        }
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "connexionSegue" {
                if self.loginSuccess != true {
                    var myMutableString = NSMutableAttributedString()
                    myMutableString = NSMutableAttributedString(string: "Identifiant :\nIdentifiant ou mot de passe incorrect.", attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 17.0)!])
                    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:13,length:39))
                    identifiantConnexionLabel.attributedText = myMutableString
                    return false
                }
            }
        }
        return true
    }

    
    
}

