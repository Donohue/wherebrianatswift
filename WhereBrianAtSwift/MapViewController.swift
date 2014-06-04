//
//  MapViewController.swift
//  WhereBrianAtSwift
//
//  Created by Brian Donohue on 6/3/14.
//  Copyright (c) 2014 Brian Donohue. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var locationManager: CLLocationManager?
    var mapView: MKMapView?
    var lastLocation: CLLocation?
    let host = "https://wherebrianat.herokuapp.com"
    let accessToken = "HIDING THIS"
    
    init()  {
        super.init(coder:nil)
        locationManager = CLLocationManager()
        locationManager!.desiredAccuracy = kCLDistanceFilterNone
        locationManager!.delegate = self
    }
    
    override func loadView() {
        self.mapView = MKMapView(frame: UIScreen.mainScreen().applicationFrame)
        self.mapView!.showsUserLocation = true
        self.mapView!.delegate = self
        self.view = self.mapView
    }
    
    override func viewDidLoad() {
        self.locationManager!.startMonitoringSignificantLocationChanges()
    }
    
    func centerMap(location: CLLocation) {
        var region = MKCoordinateRegion(center:location.coordinate, span:MKCoordinateSpanMake(0.08, 0.08))
        self.mapView!.setRegion(region, animated: true)
    }
    
    func updateLocation(location: CLLocation?) {
        if (!lastLocation || location?.distanceFromLocation(lastLocation) > 10) {
            lastLocation = location
            var manager = AFHTTPRequestOperationManager()
            var params = ["lat": location!.coordinate.longitude,
                          "lng": location!.coordinate.longitude,
                          "access_token": accessToken]
            println("latitude \(location?.coordinate.latitude), longitude: \(location?.coordinate.longitude)")
            manager.POST(host + "/submit", parameters: params,
                success: {(operation, response) in
                    println("Success")
                },
                failure: {(operation, error) in
                    println("Error: \(error.localizedDescription)")
                }
            )
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        var reuseIdentifier = "userAnnotation"
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        if (!view) {
            view = UserAnnotationView(annotation:annotation, reuseIdentifier:reuseIdentifier)
            view.canShowCallout = false
        }
        return view
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        var location = CLLocation(latitude: userLocation!.coordinate.latitude,
                                  longitude: userLocation!.coordinate.longitude)
        var equatorMeridian = CLLocation(latitude: 0, longitude: 0)
        if (equatorMeridian.distanceFromLocation(location) > 0) { //Resolve observed inaccurate position fix
            centerMap(location)
            self.updateLocation(location)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        println("Did update location")
        var location = locations[locations.count-1] as CLLocation
        self.centerMap(location)
        self.updateLocation(location)
    }
}