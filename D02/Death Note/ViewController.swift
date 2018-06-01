//
//  ViewController.swift
//  Death Note
//
//  Created by Stephane MARTINS on 5/29/18.
//  Copyright © 2018 Stephane MARTINS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBAction func unWindFromAddVC(_ sender:UIStoryboardSegue)
    {
        if sender.source is SecondViewController
        {
            if let senderVC = sender.source as? SecondViewController
            {
                Data.deaths.append(senderVC.newNote)
            }
            print(Data.deaths)
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet
        {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.deaths.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deathCell") as? DeathTableViewCell
        cell?.death = Data.deaths[indexPath.row]
        return cell!
    }
}
