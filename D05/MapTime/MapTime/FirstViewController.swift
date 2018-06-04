//
//  FirstViewController.swift
//  MapTime
//
//  Created by stephane martins on 6/4/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class PlaceAnnotation: NSObject, MKAnnotation
{
    var coordinate: CLLocationCoordinate2D    
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?)
    {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
    var region: MKCoordinateRegion
    {
        let latDelta:Double = 0.025
        let lngDelta:Double = 0.025
        print("======zoomspan===========")
        let zoomSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        return MKCoordinateRegion(center: coordinate, span: zoomSpan)
    }
   
}


class FirstViewController: UIViewController {

    @IBOutlet weak var MapView: MKMapView!
    
    let LocationManger = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapView.register(MKMarkerAnnotationView.self,
                        forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        let ftcoordinate = CLLocationCoordinate2DMake(48.896632, 2.318638)
//        let ftannotation = PlaceAnnotation(coordinate: ftcoordinate, title: "42", subtitle: "42 est l'ensemble de trois établissements privés d’autoformation en informatique situés pour l'un en France, un en Belgique et pour l'autre aux États-Unis.")
        
//        MapView.addAnnotation(ftannotation)
//        MapView.setRegion(ftannotation.region, animated: true)
        
        LocationManger.delegate = self
        LocationManger.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        LocationManger.requestAlwaysAuthorization()
        LocationManger.distanceFilter = 10
        LocationManger.startUpdatingLocation()
        

//
//        let latitude:Double = 48.896632
//        let longitude:Double = 2.318638
//
//        let locationcoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

//        self.MapView.setRegion(region, animated: true)
    }

   
}


extension FirstViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if let placeAnnotationView = MapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView
//        {
//            placeAnnotationView.animatesWhenAdded = true
//            placeAnnotationView.titleVisibility = .adaptive
//            placeAnnotationView.titleVisibility = .adaptive
//
//            return placeAnnotationView
//        }
        return nil
    }
}

extension FirstViewController: CLLocationManagerDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let currentLocation = locations.first else { return }
        let zoomSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, zoomSpan)
        
        MapView.setRegion(region, animated: true)
//        coordinate = my.coordinate
        print("laaafgkjhgkjhlfkf",currentLocation.speed)
        MapView.userTrackingMode = .followWithHeading
        
        self.MapView.showsUserLocation = true
        print("on update")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    print("__Status => ", status )
                }
            }
        }
    }
}
