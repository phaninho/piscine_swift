//
//  FirstViewController.swift
//  Map Time
//
//  Created by stephane martins on 6/5/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController {

    let LocationManger = CLLocationManager()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var curtitle = String()
    var cursubtitle = String()
    var curlatitude = Double()
    var curlongitude = Double()
    
    
    func changeMapData(content: Mapbox) {
        print("ON CHANGE MAP =================>")
        print(content.title)
//        ChangepositionOnMapView(content)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManger.requestAlwaysAuthorization()
        LocationManger.delegate = self
        LocationManger.desiredAccuracy = kCLLocationAccuracyBest
        LocationManger.distanceFilter = 10
        LocationManger.startUpdatingLocation()
        loadAllPlaces()
//        curtitle = MapData.places[0].0
//        cursubtitle = MapData.places[0].1
//        curlatitude = MapData.places[0].2
//        curlongitude = MapData.places[0].3
//        let map = Mapbox(title: curtitle, subtitle: cursubtitle, latitude: curlatitude, longitude: curlongitude)
//        setView(map: map)
//        let coordinate = CLLocationCoordinate2DMake(curlatitude, curlongitude)
      
        print("on est dams le didload du firstviewcontroller")
        print(curtitle, " ", cursubtitle)
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
//    let ftcoordinate = CLLocationCoordinate2DMake(48.896632, 2.318638)
    //        let ftannotation = PlaceAnnotation( title: "42", subtitle: "42 est l'ensemble de trois établissements privés d’autoformation en informatique situés pour l'un en France, un en Belgique et pour l'autre aux États-Unis.", latitude: 48.896632, longitude: 2.318638)
    //        MapView.addAnnotation(ftannotation)
    //        MapView.setRegion(ftannotation.region, animated: true)
    //
    ////        let latitude:Double = 48.896632
    ////        let longitude:Double = 2.318638
    ////
    ////        let locationcoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    //
    //        self.MapView.setRegion(ftannotation.region, animated: true)
    
    func loadAllPlaces()
    {
        for data in  MapData.places
        {
            curtitle = data.0
            cursubtitle = data.1
            curlatitude = data.2
            curlongitude = data.3
            let map = Mapbox(title: curtitle, subtitle: cursubtitle, latitude: curlatitude, longitude: curlongitude)
            setView(map: map)
        }
    }
    
    func setView(map: Mapbox)
    {
        let annotation = PlaceAnnotation( title: map.title, subtitle: map.subtitle, latitude: map.latitude, longitude: map.longitude)
        mapView.addAnnotation(annotation)
        mapView.setRegion(annotation.region, animated: true)
        //        let locationcoordinates = CLLocationCoordinate2D(latitude: curlatitude, longitude: curlongitude)
        self.mapView.setRegion(annotation.region, animated: true)
    }
    
    
    func updateMapData(map: Mapbox)
    {
        setView(map: map)
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
        
        mapView.setRegion(region, animated: true)
        //        coordinate = my.coordinate
        print("laaafgkjhgkjhlfkf",currentLocation.speed)
        mapView.userTrackingMode = .followWithHeading
        
        self.mapView.showsUserLocation = true
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
