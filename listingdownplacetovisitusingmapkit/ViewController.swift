//
//  ViewController.swift
//  listingdownplacetovisitusingmapkit
//
//  Created by Arsal Jamal on 26/09/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
var manager = CLLocationManager()
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        //if activeplace -1 that means nothing selected in tableview and the last place to visit should be the location on the map
        if activeplace == -1{
            manager.delegate=self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        else{
        
            //if for eg activeplace =1(1st tavleview selected and there are places in there as it would have been -1 otherwise) that means there should be atleast 2 places or more  otherwise it would give an error as dictionary of places would be empty
            if places.count > activeplace {
                
                if let name = places[activeplace]["name"] {
                   
                    if let lat = places[activeplace]["lat"] {
                        
                        if let lon = places[activeplace]["lon"] {
                            
                            if let latitude = Double(lat) {
                            
                                if let longitude = Double(lon) {
                                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                                    let region = MKCoordinateRegion(center: coordinate, span: span)
                                    self.map.setRegion(region, animated: true)
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = coordinate
                                    annotation.title = name
                                    self.map.addAnnotation(annotation)
                                    
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            
        }
    
    
    }
    func longpress(gestureRecognizer : UIGestureRecognizer){
        // convert touchpoint to coordinate and set longpress only once even if someone holds down for more than 4 secs
        if gestureRecognizer.state == UIGestureRecognizerState.began {
        let touchPoint = gestureRecognizer.location(in: self.map)
        let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            let location = CLLocation(latitude : newCoordinate.latitude, longitude : newCoordinate.longitude)
            //convert coordinate to name of location
            var title = ""
            CLGeocoder().reverseGeocodeLocation(location, completionHandler:{ (placemarks, error) in
                
                if error != nil {
                    print(error as Any)
                }
                else {
                    if let placemark = placemarks?[0] {
                        
                        if placemark.subThoroughfare != nil {
                            title += placemark.subThoroughfare! + " "
                        }
                        
                        if placemark.thoroughfare != nil {
                            title += placemark.thoroughfare! + " "
                        }
                        
                    }
                }
                if title == ""{
                    title = "added \(NSDate())"
                }
                let annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinate
                annotation.title = title
                self.map.addAnnotation(annotation)
                places.append(["name":title,"lat":String(newCoordinate.latitude),"lon":String(newCoordinate.longitude)])
                print(places)
            })
        
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
        print(locations)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

