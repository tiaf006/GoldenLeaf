//
//  LocationViewController.swift
//  GoldenLeaf
//
//  Created by TAIF Al-zahrani on 22/06/1444 AH.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseAuth

class LocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationMangager = CLLocationManager()
    var prevLocation: CLLocation? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initalLoc = CLLocation(latitude: 24.774265, longitude: 46.738586)
        setStartingLocation(location: initalLoc, distance: 3000)

        locationMangager.delegate = self
        locationMangager.desiredAccuracy = kCLLocationAccuracyBest
        locationMangager.allowsBackgroundLocationUpdates = true
        mapView.delegate = self
        if isLocationServiceEnabled() {
            checkAuthorization()
        }else{
            showAlert(msg: "please enable location service")
        }

    }
    // get location info
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let newLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        if prevLocation == nil || prevLocation!.distance(from: newLocation) > 100 {
            if prevLocation != nil {
                print("distance: \(prevLocation!.distance(from: newLocation))")
            }
            getLocationInfo(location: newLocation)
        }
       
    }
    

    func getLocationInfo(location: CLLocation){
        prevLocation = location
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { places, errorr in
            guard let places = places?.first, errorr == nil else {return}
            let reference = Database.database().reference(fromURL: "https://golden-leaf-5afdf-default-rtdb.firebaseio.com").child("User").child("\(Auth.auth().currentUser!.uid)")
                        let values = [
            //                "first name" : Auth.auth().currentUser?.lastName,
            //                          "last name" : Auth.auth().currentUser?.firstName,
                                      "email" : Auth.auth().currentUser?.email,
                                      "place name" : places.name,
                                      "place country" : places.country,
                                      "place country code" : places.isoCountryCode ,
                                      "place administrativeArea": places.administrativeArea ,
                                      "place Locality": places.locality ,
                                      "place PostalCode": places.postalCode]
                        
                        reference.setValue(values)
            
            print("----------------")
            print("place name \(places.name ?? "no name to display")")
            print("place country \(places.country ?? "no country to display")")
            print("place country code  \(places.isoCountryCode ?? "no country code to display")")
            print("place administrativeArea  \(places.administrativeArea ?? "no administrativeArea to display")")
            print("place Locality \(places.locality ?? "no Locality to display")")
            print("place PostalCode \(places.postalCode ?? "no PostalCode to display")")

        }
    }
    
    func setStartingLocation(location: CLLocation, distance: CLLocationDistance){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 24.774265, longitudinalMeters: 46.738586)
        mapView.setRegion(region, animated: true)
        
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 2150000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
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
      
        default:
            print(" default . .")
            break
        }
    }
    
    func showAlert(msg: String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close", style: .default))
        present(alert,animated: true,completion: nil)
        alert.addAction(UIAlertAction(title: "setting", style: .default, handler: { actio in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        present(alert,animated: true,completion: nil)
    }

    @IBAction func doneButton(_ sender: Any) {
    }
    
}
