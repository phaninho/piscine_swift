//
//  ViewController.swift
//  Death Note
//
//  Created by Stephane MARTINS on 5/29/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // tableView.estimatedRowHeight = 42
        // tableView.rowHeight = UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.deaths.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deathCell") as? DeathTableViewCell
        cell?.death = Data.deaths[indexPath.row]
        cell?.deathLabel?.numberOfLines = 0
        return cell!
    }
}
