//
//  MapViewController.swift
//  if26_projet_ios
//
//  Created by Thomas LS on 13/12/2018.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mMap: MKMapView!
    let pokemonDAO = PokemonDAO.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init data :
        if pokemonDAO.getAllPokemon().count == 0 {
            pokemonDAO.loadFirstGen()
        }
        // Do any additional setup after loading the view.
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
