//
//  SecondViewController.swift
//  MapTime
//
//  Created by stephane martins on 6/4/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit

protocol AddMapDataDelegate: class {
    func addMapData(content: Mapbox)
}

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: AddMapDataDelegate?

    @IBOutlet weak var tableView: UITableView!
    
    var placeAnnotations: [PlaceAnnotation]?
    
    @IBOutlet weak var SecondTableView: UITableView!
    {
        didSet
        {
            self.SecondTableView.delegate = self
            self.SecondTableView.dataSource = self

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAnnotations()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchAnnotations()
    {
        self.placeAnnotations = [PlaceAnnotation]()
        for place in MapData.places
        {
            let placeAnnotaion = PlaceAnnotation(title: place.0, subtitle: place.1, latitude: place.2, longitude: place.3)
            print("ouai ouai")
            self.placeAnnotations?.append(placeAnnotaion)
        }
        DispatchQueue.main.async
            {
                self.tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MapData.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesCell") as? PlacesTableViewCell
        cell?.placeCell = MapData.places[indexPath.row]
        return cell!
    }
    
    
}

