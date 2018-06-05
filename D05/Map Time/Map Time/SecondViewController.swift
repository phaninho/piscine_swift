//
//  SecondViewController.swift
//  Map Time
//
//  Created by stephane martins on 6/5/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit

protocol ChangeMapDataDelegate: class {
    func changeMapData(content: Mapbox)
}

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    weak var delegate: ChangeMapDataDelegate?
    
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
//        let viewController = storyboard?.instantiateViewController(withIdentifier: "FirstViewController")
//        self.delegate?.changeMapData(content: md)
        toMapView()
//        self.navigationController?.pushViewController(viewController!, animated: true)
//        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController")
//        self.present(viewController, animated: false, completion: nil)
        
    }

    func toMapView()
    {
//        self.tabBarController?.selectedIndex = 0
//        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainStoryboard") as? FirstViewController {
//            self.present(viewController, animated: false, completion: nil)
//            viewController.sayHello()
//            if let presenter = viewController.presentingViewController as? FirstViewController { presenter.sayGoodbye() }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("++++++++++++++Dns le prepare segue de FIRSTVIEEWCONTROLLER===============")
        if let nav = segue.destination as? UINavigationController, let FirstViewController = nav.topViewController as? FirstViewController {
            FirstViewController.curtitle = (mapbox?.title)!
            FirstViewController.cursubtitle = (mapbox?.subtitle)!
            FirstViewController.curlatitude = (mapbox?.latitude)!
            FirstViewController.curlongitude = (mapbox?.longitude)!
            
        }
    }
    
}

