//
//  TopicCell.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/2/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation
import UIKit

class ReplyCell: UITableViewCell {
    var message: Message? {
        didSet {
            content.text = message?.content
            author.text = message?.author.login
            id = message?.author.id
            author.attributedText = NSMutableAttributedString(string: message!.author.login, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)])
            let dateParagraph = NSMutableParagraphStyle()
            dateParagraph.alignment = .right
            createdDate.attributedText = NSMutableAttributedString(string: message!.created_at.formatDate(""), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), .paragraphStyle: dateParagraph])
        }
    }
    
    var myId : Int?
    var id : Int?
    let content: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.isScrollEnabled = false
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
    
    lazy var miniStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [author, createdDate ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let cell: UIView =  {
        let cell = UIView()
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.backgroundColor = .lightGreen
        cell.layer.borderColor = UIColor.lightGreen.cgColor
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(cell)
        selectionStyle = .none
        backgroundColor = .black

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
