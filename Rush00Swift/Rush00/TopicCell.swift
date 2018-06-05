//
//  TopicCell.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/2/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation
import UIKit

func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
{
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}

class TopicCell: UITableViewCell {
    var topic: Topic? {
        didSet {
            guard let top = topic else {return}
            
            let titleParagraph = NSMutableParagraphStyle()
            titleParagraph.alignment = .center
            title.attributedText = NSMutableAttributedString(string: top.name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), .paragraphStyle: titleParagraph])
//            author.text = top.author.login
            
            let dateParagraph = NSMutableParagraphStyle()
            dateParagraph.alignment = .right
            let auth = NSMutableAttributedString(string: top.author.login, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: UIColor.purple])
            let createdBy = NSMutableAttributedString(string: "Created by ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)])
            let createdDate = NSMutableAttributedString(string: " on " + top.created_at.formatDate("date"), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)])
            
            author.attributedText = createdBy + auth + createdDate
            
            
            dateUpdated.attributedText = NSMutableAttributedString(string: "Last updated: " + top.updated_at.formatDate(""), attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 14), .paragraphStyle: dateParagraph])
        }
    }
    
    private let cellView: UIView =  {
        let cell = UIView()
//        cell.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
//        cell.layer.borderColor = UIColor.blueGray.cgColor
//        cell.layer.borderWidth = 2
//        cell.layer.cornerRadius = 5
//        cell.backgroundColor = .green
        
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()
    
    let title: UITextField = {
        let textField = UITextField()
//        textField.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        textField.backgroundColor = .blueGray
        textField.layer.cornerRadius = 10
//        textField.textColor = .white
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let author: UITextField = {
        let textField = UITextField()
//        textField.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)

        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
//    let dateCreated: UITextField = {
//        let textField = UITextField()
////        textField.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
//
//        textField.isUserInteractionEnabled = false
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()

    let dateUpdated: UITextField = {
        let textField = UITextField()
//        textField.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        textField.isUserInteractionEnabled = false
        textField.textColor = .gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [author, dateUpdated])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(cellView)
        selectionStyle = .none
        cellView.addSubview(title)
        cellView.addSubview(stackView)
 
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalToConstant: 35),
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -2),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2),
            title.topAnchor.constraint(equalTo: cellView.topAnchor),
            title.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),

            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10)])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
