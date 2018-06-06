//
//  SecondViewController.swift
//  Map Time
//
//  Created by stephane martins on 6/5/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var mapbox: Mapbox?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet
        {
            print("dans le didset du tableview secondviewcontroller")
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("+++ ViewDidLoas DE SecondViewController==================")
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MapData.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesCell") as? PlacesTableViewCell
        cell?.placeCell = MapData.places[indexPath.row]
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let md = Mapbox(title: MapData.places[indexPath.row].0,subtitle: MapData.places[indexPath.row].1,latitude: MapData.places[indexPath.row].2,longitude: MapData.places[indexPath.row].3)
        mapbox = md
        toMapView(map: md)
    }

    func toMapView(map: Mapbox)
    {
        print("tomapView============>")
        let firstView = tabBarController?.viewControllers![0] as! FirstViewController
        firstView.updateMapData(map: map)
//        let region = MKCoordinateRegionMakeWithDistance(locations[indexPath.item].annotationPin.coordinate, 3000, 3000)
//        firstView.mapView.setRegion(region, animated: true)
        tabBarController?.selectedIndex = 0
    }
    
}

