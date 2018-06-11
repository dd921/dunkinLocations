//
//  ViewController.swift
//  findLocation
//
//  Created by Dan DeAngelis on 6/5/18.
//  Copyright © 2018 deangelisLogic. All rights reserved.
//

/*
  - "To Do" : Add All Dunkins Locations in Boston (Find Location Data File online), center around a fixed point
  - Create startup screen with button saying "Click to view all dunkin donuts locations"
*/

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!  //The Map
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations[0] //get most recent position of user
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.2,0.2) // Need to figure out the best starting zoom level, 0.2 works well for now
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude,userLocation.coordinate.longitude) //Map centered around user
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
                
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
    
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        //User Location
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
        //Pin Locations
        struct Location {
            let title: String
            let latitude : Double
            let longitude: Double
        }
        
        // Hard coded 10 locations; idealy need to find a data file with all locations (65 in Boston, 300+ in Greater Boston Area)
        let pinLocations = [
            Location(title: "Dunkin Donuts 1",    latitude: 42.346458, longitude: -71.098591),
            Location(title: "Dunkin Donuts 2",    latitude: 42.348572, longitude: -71.096281),
            Location(title: "Dunkin Donuts 3",    latitude: 42.350377, longitude: -71.104873),
            Location(title: "Dunkin Donuts 4",    latitude: 42.341184, longitude: -71.089261),
            Location(title: "Dunkin Donuts 5",    latitude: 42.350687, longitude: -71.079829),
            Location(title: "Dunkin Donuts 6",    latitude: 42.339903, longitude: -71.088029),
            Location(title: "Dunkin Donuts 7",    latitude: 42.345325, longitude: -71.040488),
            Location(title: "Dunkin Donuts 8",    latitude: 42.352017, longitude: -71.047125),
            Location(title: "Dunkin Donuts 9",    latitude: 42.335766, longitude: -71.045547),
            Location(title: "Dunkin Donuts 10",   latitude: 42.335886, longitude: -71.056014)
        ]
        
        //Place each annotation in pinLocations
        for location in pinLocations {
            let annotation = MKPointAnnotation()
            annotation.title = location.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.addAnnotation(annotation)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

