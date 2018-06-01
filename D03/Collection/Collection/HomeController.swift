//
//  ViewController.swift
//  Collection
//
//  Created by stephane martins on 5/31/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import UIKit

let qos = DispatchQoS.background.qosClass

let queue = DispatchQueue.global(qos: qos)


class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    var images: [Image]?

    func fetchImages()
    {
        self.images = [Image]()
        for url in DataAddr.addr
        {
            let image = Image()
            image.url = url
            self.images?.append(image)
        }
        queue.async {
            DispatchQueue.main.async
                {
                    self.collectionView?.reloadData()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
        
        navigationItem.title = "Home"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(imageCell.self, forCellWithReuseIdentifier: "cellId")
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    //    change l'espacement minimum entre chaque elements
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! imageCell
        cell.image = images?[indexPath.item]
        return cell
    }
}
