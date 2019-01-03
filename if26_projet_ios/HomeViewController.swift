//
//  HomeViewController.swift
//  if26_projet_ios
//
//  Created by Louis ALBERT on 03/01/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var identifiantLabel:String  = "Identifiant :"
    @IBOutlet weak var identifiantConnexionLabel: UILabel!
    @IBOutlet weak var mdpConnexionTextField: UITextField!
    @IBOutlet weak var identifiantConnexionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: identifiantLabel, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 17.0)!])
        
        if identifiantLabel == "Identifiant :\nLa confirmation du mot de passe n'est pas valide."{
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:13,length:50))
        }
        identifiantConnexionLabel.attributedText = myMutableString
        
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
