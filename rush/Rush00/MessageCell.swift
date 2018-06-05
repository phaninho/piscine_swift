//
//  File.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/2/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation
import UIKit

class MessageCell: UITableViewCell {

    var id: Int?
    var myId: Int?
    var token: String?
    var message: Message? {
        didSet {
            guard let mess = message else {return}
            content.text = mess.content
            id = mess.author.id
            if id == myId {
                miniStackView.addArrangedSubview(button)
                let tap = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
                tap.delegate = self
                cell.addGestureRecognizer(tap)
            }
            author.attributedText = NSMutableAttributedString(string: mess.author.login, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])

            let dateParagraph = NSMutableParagraphStyle()
            dateParagraph.alignment = .right
            createdDate.attributedText = NSMutableAttributedString(string: mess.created_at.formatDate(""), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), .paragraphStyle: dateParagraph])
        }
    }
    
    var superVC: APIRefreshMessagesDelegate?
    var apiController: ApiDeleteMessagesController?
    
    
    let content: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = false
//        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let author: UITextField = {
        let view = UITextField()
        //        view.backgroundColor = .cyan
        view.textColor = .white
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let createdDate: UITextField = {
        let view = UITextField()
        view.isUserInteractionEnabled = false
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Delete",for: .normal)
        
        button.backgroundColor = .black
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func buttonAction() {
        print("press Delete")
        guard let _ = superVC, let _ = id, let _ = token else {return }
        apiController = ApiDeleteMessagesController(APIdelegate: superVC!, id: message!.id, token: token!)
    }
    
    lazy var miniStackView: UIStackView = {
        var stackView = UIStackView()
            stackView = UIStackView(arrangedSubviews: [author, createdDate])
        stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let cell: UIView =  {
        let cell = UIView()
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.backgroundColor = .lightRed
        cell.layer.borderColor = UIColor.lightRed.cgColor
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(cell)
        backgroundColor = .black
        selectionStyle = .none
        cell.addSubview(content)
        cell.addSubview(miniStackView)
        
        NSLayoutConstraint.activate([
            cell.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            cell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
    
            miniStackView.topAnchor.constraint(equalTo: cell.topAnchor),
            miniStackView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 10),
            miniStackView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10),
                       miniStackView.heightAnchor.constraint(equalToConstant: 25),
            content.topAnchor.constraint(equalTo: miniStackView.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
