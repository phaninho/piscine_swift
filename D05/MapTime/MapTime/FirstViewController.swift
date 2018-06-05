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

class FirstViewController: UIViewController, AddMapDataDelegate {
    
    func addMapData(content: Mapbox) {
        print("ON ADD MAP =================>")
        ChangepositionOnMapView(content)
    }
    
    
    @IBOutlet weak var MapView: MKMapView!
    
    let LocationManger = CLLocationManager()
    
    var centerMapButton: MKUserTrackingButton?
   
    var maps: [Mapbox]?
    var currentTitle: String?
    var currentSubtitle: String?
    var currentLatitude: Double?
    var currentLongitude: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapView.register(MKMarkerAnnotationView.self,
                        forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        print("je rentre")
        self.centerMapButton = MKUserTrackingButton.init(mapView: self.MapView)
        setupUserTrackingButtonAndScaleView()
        setViewOnce()
//        let ftcoordinate = CLLocationCoordinate2DMake(48.896632, 2.318638)
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nav = segue.destination as? UINavigationController, let SecondViewController = nav.topViewController as? SecondViewController {
            SecondViewController.delegate = self
        }
    }
    
    func ChangepositionOnMapView(_ content: Mapbox?) {

        currentTitle = (content?.title)!
        currentSubtitle = (content?.subtitle)!
        currentLatitude = (content?.latitude)!
        currentLongitude = (content?.longitude)!
        let zoomSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLatitude!, currentLongitude!)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, zoomSpan)
        DispatchQueue.main.async {
            self.MapView.setRegion(region, animated: true)
        }
//        view.backgroundColor = color
    }
    
    func setViewOnce()
    {
        
    }
    
    func setupUserTrackingButtonAndScaleView() {
        MapView.showsUserLocation = true
        print("BINGooooooooooooooooooo")
        let button = MKUserTrackingButton(mapView: MapView)
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        let scale = MKScaleView(mapView: MapView)
        scale.legendAlignment = .trailing
        scale.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scale)
        
        NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                                     button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
                                     scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
    }
//
//    func loadMap(placesArray: [MapData]) {
//        self.forumTopics = placesArray
//        print(topicsArray.count)
//        tableView.reloadData()
//    }
//
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
