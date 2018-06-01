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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
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
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews()
    {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImageView]))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImageView, "v1": separatorView]))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": separatorView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
