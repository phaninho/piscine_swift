//
//  TopicViewController.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/2/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation
import UIKit

class TopicViewController: UIViewController, APIMessagesDelegate, UITableViewDataSource, UITableViewDelegate, APIRefreshMessagesDelegate, AddMessageDelegate{
    func reloadMessages() {
        guard let top = topic, let tok = token else { return }
        apiController = ApiGetMessagesController(APIdelegate: self, id: top.id, token: tok)
    }
    
    func add(content:String) {
        print("before add")
        apiPostController = ApiAddMessagesController(APIdelegate: self, topicId: topic!.id, token: token!, authorId: myId!, content: content)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
   
    var apiPostController :ApiAddMessagesController?
    var messagesArray: [Message]?
    let addVC = AddMessageViewController()
    var apiController: ApiGetMessagesController?
    var token : String?
    var myId: Int?
    var topic : Topic? {
        didSet {
            guard let top = topic, let tok = token else { return }
            
            topicAuthor.attributedText = NSMutableAttributedString(string: top.author.login, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)])
            
        
            let titleParagraph = NSMutableParagraphStyle()
            titleParagraph.alignment = .center
            topicName.attributedText = NSMutableAttributedString(string: top.name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), .paragraphStyle: titleParagraph, NSAttributedStringKey.foregroundColor: UIColor.darkBlue])
            

            
            let dateParagraph = NSMutableParagraphStyle()
            dateParagraph.alignment = .right
            createdDate.attributedText = NSMutableAttributedString(string: top.updated_at.formatDate(""), attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), .paragraphStyle: dateParagraph])
            
//            print("content->>>", top.message.content.markdown)
//            topicMessageContent.text = top.message.content.markdown
            apiController = ApiGetMessagesController(APIdelegate: self, id: top.id, token: tok)
        }
    }
    
    let topicName: UITextField = {
       let view = UITextField()
                view.backgroundColor = UIColor.myGray
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topicAuthor: UITextField = {
        let view = UITextField()
        view.backgroundColor = UIColor.myGray
         view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let createdDate: UITextField = {
        let view = UITextField()
        view.isUserInteractionEnabled = false
               view.backgroundColor = UIColor.myGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var miniStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topicAuthor, createdDate ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
//    let topicMessageContent: UITextView = {
//        let view = UITextView()
//        view.isUserInteractionEnabled = false
//        view.backgroundColor = .brown
//        view.isScrollEnabled = false
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    lazy var topicStackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topicName, miniStackView ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor.myGray
        stackView.axis = .vertical
        return stackView
    }()
    
    let tableView : UITableView! = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    
        tableView.register(MessageCell.self, forCellReuseIdentifier : "MCell")
        tableView.register(ReplyCell.self, forCellReuseIdentifier : "RCell")
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messagesArray {
            return messages.count}
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messagesArray![indexPath.item].parent_id != nil {
             let myCell = tableView.dequeueReusableCell(withIdentifier: "RCell", for: indexPath) as! ReplyCell
            myCell.message = messagesArray![indexPath.item]
            myCell.myId = myId!
            return myCell
        }
        let myCell = tableView.dequeueReusableCell(withIdentifier: "MCell", for: indexPath) as! MessageCell
        myCell.myId = myId
        myCell.superVC = self
        myCell.token = token
        myCell.message = messagesArray![indexPath.item]
        return myCell
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        setupView()
    }
    
    @objc func addTapped() {
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: false)
    }
    
    private func setupView() {
        view.addSubview(topicStackView)
        view.addSubview(tableView)
        view.backgroundColor = UIColor.myGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        NSLayoutConstraint.activate([
            topicName.heightAnchor.constraint(equalToConstant: 60),
            topicName.leadingAnchor.constraint(equalTo: topicStackView.leadingAnchor, constant: 10),
            topicName.trailingAnchor.constraint(equalTo: topicStackView.trailingAnchor, constant: -10),
            miniStackView.leadingAnchor.constraint(equalTo: topicStackView.leadingAnchor, constant: 10),
            miniStackView.trailingAnchor.constraint(equalTo: topicStackView.trailingAnchor, constant: -10),
            miniStackView.heightAnchor.constraint(equalToConstant: 30),
            topicStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topicStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topicStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: topicStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
    }
    
    func updateMessages(messagesArray: [Message]) {
        self.messagesArray = messagesArray
     
        tableView.reloadData()
    }
    
    
}
