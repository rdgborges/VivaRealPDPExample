//
//  ViewController.swift
//  VivaRealPropertyDetails
//
//  Created by Rodrigo Soares on 25/01/16.
//  Copyright © 2016 VivaReal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VRPropertyDetailsCollectionViewLayoutDelegate {

    @IBOutlet var collectionView: UICollectionView!
    var collectionViewDataSource: VRCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.reloadData()
        
        super.viewDidAppear(animated)
    }

    func setupCollectionView() {
        if let layout = collectionView?.collectionViewLayout as? VRPropertyDetailsCollectionViewLayout {
            layout.delegate = self
        }
        
        self.collectionView.registerNib(UINib(nibName: "VRPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photosCollectionViewCellIdentifier")
        self.collectionView.registerNib(UINib(nibName: "VRPropertyInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "propertyInfoCollectionViewCellIdentifier")
        self.collectionView.registerNib(UINib(nibName: "VRDescriptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "descriptionCollectionViewCellIdentifier")
        
        self.collectionViewDataSource = VRCollectionViewDataSource()
        self.collectionView.dataSource = self.collectionViewDataSource
        
    }
    
    //MARK: VRPropertyDetailsCollectionViewLayoutDelegate
    
    func heightForItemAtIndexPath(indexPath: NSIndexPath, withWidth:CGFloat) -> CGFloat {
            return self.collectionViewDataSource.sizeForCell(atIndex: indexPath, collectionViewWidth: withWidth).height
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.reloadData()
    }
    
}

