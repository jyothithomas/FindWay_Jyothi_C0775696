//
//  ViewController.swift
//  FindWay_Jyothi_C0775696
//
//  Created by user176475 on 6/9/20.
//  Copyright © 2020 user176475. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet private var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        mapView.centerToLocation(initialLocation)
        let oahuCenter = CLLocation(latitude: 21.4765, longitude: -157.9647)
        let region = MKCoordinateRegion(
          center: oahuCenter.coordinate,
          latitudinalMeters: 50000,
          longitudinalMeters: 60000)
        mapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)

    }
    @objc func handleLongPress(_ gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state != .began { return }

        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

        let album = Album(coordinate: touchMapCoordinate, ,subtitle: self)
//
        mapView.addAnnotation(album)
    }

}
private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

class Album: NSObject, MKAnnotation {

    var coordinate = CLLocationCoordinate2DMake(0, 0)
    var title: String?
    var subtitle: String?


    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String)
        {

        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }

}
