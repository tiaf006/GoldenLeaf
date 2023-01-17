//
//  MyLocationVC.swift
//  GoldenLeaf
//
//  Created by maram  on 24/06/1444 AH.
//

import UIKit
import MapKit
import CoreLocation


class MyLocationVC: UIViewController, CLLocationManagerDelegate {

    var locationMangager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationMangager.delegate = self
        locationMangager.desiredAccuracy = kCLLocationAccuracyBest
        locationMangager.allowsBackgroundLocationUpdates = true
        
        if isLocationServiceEnabled() {
            checkAuthorization()
        }else{
            showAlert(msg: "please enable location service")
        }
        
        
    }
    func isLocationServiceEnabled() -> Bool{
        return CLLocationManager.locationServicesEnabled()
    }
    
    
    func checkAuthorization(){
        switch locationMangager.authorizationStatus {
        case .notDetermined:            // first time to open the app
            locationMangager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:          // give the access ontime of use the app
            locationMangager.requestAlwaysAuthorization()
            locationMangager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways:            // While using the application and the background
            locationMangager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied:                      // denied the access
            showAlert(msg: "Please authorize access to location")
            break
        case .restricted:                   // unable to access
            showAlert(msg: " Authorize restricted")
            break
        default:
            print(" default . .")
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("location \(location.coordinate)")
            zoomToUserLocation(location: location)
        }
        locationMangager.stopUpdatingLocation()
    }
    func zoomToUserLocation(location: CLLocation){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:          // give the access ontime of use the app
            locationMangager.requestAlwaysAuthorization()
            locationMangager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways:            // While using the application and the background
            locationMangager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied:                      // denied the access
            showAlert(msg: "Please authorize access to location")
            break
      
        default:
            print(" default . .")
            break
        }
    }
    
    func showAlert(msg: String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close", style: .default))
        present(alert,animated: true,completion: nil)
    }

}
