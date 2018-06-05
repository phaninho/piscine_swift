//
//  imageCell.swift
//  Collection
//
//  Created by stephane martins on 6/1/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit


class imageCell: UICollectionViewCell
{
    var image: Image?
    {
        didSet
        {
            setupThumbNaiImage()
        }
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupThumbNaiImage()
    {
        if let thumbNailImageUrl = image?.url
        {
            thumbnailImageView.loadImageWithURL(urlString: thumbNailImageUrl)
        }
    }
    
    let thumbnailImageView: customImageView =
    {
        let imageView = customImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false

            var img = customImageView()
            imageView.image = UIImage()
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews()
    {
        
        addSubview(thumbnailImageView)
    
//        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor)
//
//        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImageView]))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImageView, "v1": separatorView]))
        
//        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
