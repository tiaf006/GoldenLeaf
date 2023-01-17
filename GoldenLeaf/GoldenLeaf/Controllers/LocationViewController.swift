//
//  LocationViewController.swift
//  GoldenLeaf
//
//  Created by TAIF Al-zahrani on 22/06/1444 AH.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initalLoc = CLLocation(latitude: 24.774265, longitude: 46.738586)
        setStartingLocation(location: initalLoc, distance: 3000)
        addAnnotation()
    }
    
    func setStartingLocation(location: CLLocation, distance: CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 24.774265, longitudinalMeters: 46.738586)
        mapView.setRegion(region, animated: true)
        
        // lamited bondray
//        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 2150000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
    }
    func addAnnotation(){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 24.774265, longitude: 46.738586)
        pin.title = "My Title"
        pin.subtitle = "My Pin Subtitle"
        mapView.addAnnotation(pin)
        
    }
    
}
