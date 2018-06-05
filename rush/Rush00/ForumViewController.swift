//
//  ForumViewController.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/2/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation

protocol LogoutDelegate: class {
    func logout()
}

import UIKit
class ForumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIDelegate {
 
    var delegate: LogoutDelegate?
    var forumTopics: [Topic]?
    var apiController: ApiGetTopicsController?
    var topicView: TopicViewController?
    var myId: Int?
    var token: String? {
        didSet {
            guard let tok = token else { return }
             apiController = ApiGetTopicsController(APIdelegate: self, token: tok)
        }
    }
    let tableView : UITableView! = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TopicCell.self, forCellReuseIdentifier : "Cell")
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let topics = forumTopics {
            print(topics.count)
            return topics.count}
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let myCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TopicCell
        myCell.topic = forumTopics?[indexPath.item]

        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topic = forumTopics![indexPath.item]
        topicView?.token = self.token!
        topicView?.topic = topic
        topicView?.myId = myId!
       

        DispatchQueue.main.async {
            self.navigationController?.pushViewController(self.topicView!, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topicView = TopicViewController()
        setupTable()
        navigationItem.hidesBackButton = true
//        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logoutTapped))
        navigationItem.leftBarButtonItem?.isEnabled = true
       
        
    
        navigationItem.title = "FORUM"
    }
    
    @objc func logoutTapped() {
         apiController!.task!.cancel()
        self.token = nil
        forumTopics = []
        tableView.reloadData()
        delegate!.logout()
        navigationController?.popViewController(animated: true)
        print("logout")
    }
    
     let text :UITextView = {
       let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .purple
        text.text = "fdsfds"
        return text
    }()
    
    func setupTable() {
//        view.addSubview(tableView)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

//
        NSLayoutConstraint.activate([
           tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableView.heightAnchor.constraint(equalToConstant: 300)
            ])
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////
    func loadForum(topicsArray: [Topic]) {
        self.forumTopics = topicsArray
        print(topicsArray.count)
        tableView.reloadData()
    }
    
}
//
