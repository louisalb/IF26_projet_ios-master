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



class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var pseudo:String = ""
    var logoutSuccess:Bool = false
    
    @IBOutlet weak var mMap: MKMapView!
    var locationManager = CLLocationManager()
    let pokemonDAO = PokemonDAO.init()
    
    
    @IBOutlet weak var pseudoMapLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       pseudoMapLabel.text = pseudo
        // init data :
        if pokemonDAO.getAllPokemon().count == 0 {
            pokemonDAO.loadFirstGen()
        }
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 400, longitudinalMeters: 400)
            mMap.setRegion(viewRegion, animated: false)
            mMap.showsUserLocation = true
            mMap.delegate = self
        }
        
        self.locationManager = locationManager
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(addPokestop(longGesture:)))
        mMap.addGestureRecognizer(longGesture)
    }
    @IBAction func quitter(_ sender: UIButton) {
        self.createAlert()
    }
    
    @objc func addPokestop(longGesture: UIGestureRecognizer) {
        if longGesture.state == .began {
            var touchPoint = longGesture.location(in: mMap)
            var newCoordinates = mMap.convert(touchPoint, toCoordinateFrom: mMap)
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinates
            
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: newCoordinates.latitude, longitude: newCoordinates.longitude), completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                
                if placemarks!.count > 0 {
                    let pm = placemarks![0] as! CLPlacemark
                    
                    // not all places have thoroughfare & subThoroughfare so validate those values
                    annotation.title = pm.thoroughfare! + ", " + pm.subThoroughfare!
                    annotation.subtitle = pm.subLocality
                    self.mMap.addAnnotation(annotation)
                    print(pm)
                }
                else {
                    annotation.title = "Unknown Place"
                    self.mMap.addAnnotation(annotation)
                    print("Problem with the data received from geocoder")
                }
                //.append(["name":annotation.title,"latitude":"\(newCoordinates.latitude)","longitude":"\(newCoordinates.longitude)"])
            })
            //self.performSegue(withIdentifier: "longTouchSegue", sender: nil)
        }
    }
    
    
    func createAlert ()
    {
        let alert = UIAlertController(title: "Déconnexion", message: "Voulez-vous vous déconnecter ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ANNULER", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
           
        }))
        
        alert.addAction(UIAlertAction(title: "OUI", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
             self.logoutSuccess = true
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            let defaults = UserDefaults.standard
            defaults.set("", forKey: "Session en cours")
        }))
        
        self.present(alert, animated: true, completion: nil)
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
