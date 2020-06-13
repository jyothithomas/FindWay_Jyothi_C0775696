//
//  ViewController.swift
//  FindWay_Jyothi_C0775696
//
//  Created by user176475 on 6/9/20.
//  Copyright © 2020 user176475. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var locatioManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
// Do any additional setup after loading the view.

        mapView.showsUserLocation = true
        //we give the delegate of location manager to this class
        locatioManager.delegate = self
        //desired accuracy of the location
        locatioManager.desiredAccuracy = kCLLocationAccuracyBest
        //request the user for the location access
        locatioManager.requestWhenInUseAuthorization()
        // start updating the location of the user
        locatioManager.startUpdatingLocation()
        // 1- define the latitude and longitude
        let latitude: CLLocationDegrees = 43.64
        let longitutde: CLLocationDegrees = -79.38
        displayLocation(latitude: latitude, longitude: longitutde, title: "I am here", subTitle: "Beautiful City")
        //long press gesture
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(addLongPressAnnotation))
        mapView.addGestureRecognizer(uilpgr)
//        //double tap gesture

//        let uidtgr = UITapGestureRecognizer(target: self, action: addDoubleTap())
        addDoubleTap()

    }
    //MARK: add long press gesture recognizer for the annotation
    @objc func addLongPressAnnotation(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        //add annotation
        let annotation = MKPointAnnotation()
        annotation.title = "My Destination"
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
        doubleTap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(doubleTap)
    }
    @objc func dropPin(sender: UITapGestureRecognizer){
        removePin()
        let touchPoint = sender.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        //add annotation
        let annotation = MKPointAnnotation()
        annotation.title = "My Destination"
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    //MARK: didUpdateLocation method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        displayLocation(latitude: latitude, longitude: longitude, title: "Your Location", subTitle: "You are here")
    }
    //MARK: display user location method

    func displayLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subTitle: String) {
        let latDelta: CLLocationDegrees = 0.05
        let lngDelta: CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // set region for the map
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        //add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Toronto Downtown"
        annotation.subtitle = "Beautiful City"
        mapView.addAnnotation(annotation)

    }
    func removePin()
    {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
}
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
}
