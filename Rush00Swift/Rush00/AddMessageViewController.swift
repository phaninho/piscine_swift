//
//  AddMessageViewController.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/3/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//


import UIKit

protocol AddMessageDelegate: class {
    func add(content: String)
}

class AddMessageViewController: UIViewController {
    weak var delegate: AddMessageDelegate?

    let textView: UITextView = {
        let text = UITextView()
        text.backgroundColor = .backgroundGray
        text.isScrollEnabled = true
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 18)
        text.layer.cornerRadius = 15.0
        text.isUserInteractionEnabled = true
        text.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return text
    }()
    
    var VC: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "edit page"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem?.isEnabled = true
        view.addSubview(textView)
        hideKeyboardWhenTappedAround()
        setupView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    @objc func doneTapped() {
        let message: String = textView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        textView.text = ""
        print(message)
        DispatchQueue.main.async {
             self.delegate?.add(content: message)
        }
        
        navigationController?.popViewController(animated: true)
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            ])
    }
    
  
}


