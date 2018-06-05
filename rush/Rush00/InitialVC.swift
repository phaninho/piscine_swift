//
//  InitialVC.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/3/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation
import UIKit
class InitialVC : UIViewController  {
   
    let button: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .yellow
        button.setTitle("?", for: .normal)
        let title = NSMutableAttributedString(string: "?", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 80)])
        button.setAttributedTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        return button
    }()
    
    @objc func buttonAction() {
        let newView = ViewController()
         self.navigationController?.pushViewController(newView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        navigationController?.navigationBar.barTintColor = .black
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
        ])
        
    }
}
