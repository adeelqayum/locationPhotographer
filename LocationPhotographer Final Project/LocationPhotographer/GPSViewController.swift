//
//  GPSViewController.swift
//  LocationPhotographer
//
//  Created by Adeel Qayum on 11/25/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class GPSViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var countryField: UITextField!
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var streetField: UITextField!
    
    @IBOutlet weak var coordinatesLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var streetLabel: UILabel!
    
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var getCoordinateButton: UIButton!
    
    var colorArray = [UIColor(red: 164/255.0, green: 224/255.0, blue: 233/255.0, alpha: 1), UIColor(red: 244/255.0, green: 243/255.0, blue: 215/255.0, alpha: 1), UIColor(red: 230/255.0, green: 236/255.0, blue: 248/255.0, alpha: 1), UIColor.red, UIColor.brown, UIColor.green, UIColor.gray]
    
    
    var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 244/255.0, green: 243/255.0, blue: 215/255.0, alpha: 1)
        
        countryLabel.text = NSLocalizedString("str_country", comment: "")
        cityLabel.text = NSLocalizedString("str_city", comment: "")
        streetLabel.text = NSLocalizedString("str_street", comment: "")
        orLabel.text = NSLocalizedString("str_or", comment: "")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    
    @objc  func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if (self.tabBarController?.selectedIndex)! < 2
            { // set here  your total tabs
                self.tabBarController?.selectedIndex += 1
            }
        } else if gesture.direction == .right {
            if (self.tabBarController?.selectedIndex)! > 0 {
                self.tabBarController?.selectedIndex -= 1
            }
        }
    }
    
    @objc func doubleTapped() {
        let currentIndex = colorArray.index(of: self.view.backgroundColor!)
        let newColor = getNextColor(index: currentIndex!)
        self.view.backgroundColor = newColor
    }
    
    func getNextColor(index: Int) -> UIColor {
        var newIndex = index + 1
        if (newIndex > (colorArray.count - 1)) {
            newIndex = 0
        }
        return colorArray[newIndex]
    }
    
    @IBAction func getCoordiantesButton(_ sender: Any) {
        guard let country = countryField.text else { return }
        guard let street = streetField.text else { return }
        guard let city = cityField.text else { return }
        
        
        let addressString = "\(country), \(city), \(street)"
        
        
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {

        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            /*coordinatesLabel.text = "Unable to Find Location for Address"*/

            
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                /*coordinatesLabel.text = "\(coordinate.latitude), \(coordinate.longitude)"*/
                locationAlert(coordinates: "\(coordinate.latitude), \(coordinate.longitude)")
                
            } else {
                /*coordinatesLabel.text = "No Matching Location Found"*/
                 locationAlert(coordinates: "No Matching Location Found")
 
            }
        }
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        /*coordinatesLabel.text = "\(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)"*/
        locationAlert(coordinates: "\(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
  
    @IBAction func yourLocation(_ sender: Any) {
        determineMyCurrentLocation()
    }
    
    func locationAlert(coordinates: String) {
        
        let alert = UIAlertController(title: NSLocalizedString("str_locationalert", comment: ""),
                                      message: coordinates,
                                      preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_ok", comment: ""),
                                         style: .cancel, handler:nil)
        alert.addAction(cancelAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
