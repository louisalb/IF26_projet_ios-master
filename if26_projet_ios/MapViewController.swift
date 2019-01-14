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

    var logoutSuccess:Bool = false
    let annotation = MKPointAnnotation()
    var nomPokestopPourSegue:String = String()
    
    @IBOutlet weak var imageInfo: UIImageView!
    @IBOutlet weak var mMap: MKMapView!
    var locationManager = CLLocationManager()
    let pokemonDAO = PokemonDAO.init()
    
    
    @IBOutlet weak var pseudoMapLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageInfo.isHidden = true
        let defaults = UserDefaults.standard
        let savedPseudo:String = defaults.object(forKey: "Session en cours") as? String ?? ""
       pseudoMapLabel.text = savedPseudo
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
        
        let pokestopDAO:PokestopDAO = PokestopDAO()
        let pokestopsArray:Array<Pokestop> = pokestopDAO.getAllPokestop()
        for pokestop in pokestopsArray {
            let pin:MyPointAnnotation = MyPointAnnotation()
            pin.title = pokestop.getNom()
            pin.coordinate = CLLocationCoordinate2D(latitude: pokestop.getLatitude(), longitude: pokestop.getLongitude())
            if pokestop.getIs_gym() == true {
                pin.markerTintColor = .green
            }
            self.mMap.addAnnotation(pin)
        }
    }
    @IBAction func quitter(_ sender: UIButton) {
        self.createAlertQuitter()
    }
    
    @IBAction func infos(_ sender: UIButton) {
        if self.imageInfo.isHidden == true {
            self.imageInfo.isHidden = false
        }
        else{
            self.imageInfo.isHidden = true
        }
    }
    @IBAction func centrer(_ sender: UIButton) {
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
    }
    @objc func addPokestop(longGesture: UIGestureRecognizer) {
        if longGesture.state == .began {
            let touchPoint = longGesture.location(in: mMap)
            let newCoordinates = mMap.convert(touchPoint, toCoordinateFrom: mMap)
            annotation.coordinate = newCoordinates
            self.createAlertPokestop()
        }
    }
    
    func createAlertPokestop ()
    {
        let alert = UIAlertController(title: "Pokestop", message: "Voulez-vous ajouter un Pokestop ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ANNULER", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "OUI", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "longTouchSegue", sender: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlertQuitter ()
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "longTouchSegue" {
            if let destinationVC = segue.destination as? PokestopViewController {
                destinationVC.latitude = self.annotation.coordinate.latitude
                destinationVC.longitude = self.annotation.coordinate.longitude
                destinationVC.token = true
                
            }
        }
        if segue.identifier == "pokemonSegue" {
            if let destinationVC = segue.destination as? PokemonViewController {
                destinationVC.nomPokestop = self.nomPokestopPourSegue
                
            }
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MyPointAnnotation else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.markerTintColor = annotation.markerTintColor
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.nomPokestopPourSegue = ((view.annotation?.title)!)!
        performSegue(withIdentifier: "pokemonSegue", sender: nil)
    }
}
