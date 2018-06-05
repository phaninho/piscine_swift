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
//        print(md.title, " ", md.subtitle)
//        let viewController = storyboard?.instantiateViewController(withIdentifier: "FirstViewController")
//        self.delegate?.changeMapData(content: md)
        toMapView(map: md)
//        self.navigationController?.pushViewController(viewController!, animated: true)
//        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController")
//        self.present(viewController, animated: false, completion: nil)
        
    }

    func toMapView(map: Mapbox)
    {
        print("tomapView============>")
        let firstView = tabBarController?.viewControllers![0] as! FirstViewController
        firstView.copyData(map: map)
//        let region = MKCoordinateRegionMakeWithDistance(locations[indexPath.item].annotationPin.coordinate, 3000, 3000)
//        firstView.mapView.setRegion(region, animated: true)
        tabBarController?.selectedIndex = 0
    }
    
}

