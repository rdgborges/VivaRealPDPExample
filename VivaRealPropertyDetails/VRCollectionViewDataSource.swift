//
//  VRCollectionViewDataSource.swift
//  VivaRealPropertyDetails
//
//  Created by Rodrigo Soares on 25/01/16.
//  Copyright © 2016 VivaReal. All rights reserved.
//

import UIKit

class VRCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0: return pictureCell(collectionView, atIndexPath: indexPath)
        case 1: return infosCell(collectionView, atIndexPath: indexPath)
        default: return descriptionCell(collectionView, atIndexPath: indexPath)
        }
        
    }
    
    func pictureCell(collectionView: UICollectionView, atIndexPath : NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photosCollectionViewCellIdentifier", forIndexPath: atIndexPath) as! VRPhotosCollectionViewCell

        
        return cell
    }
    
    func infosCell(collectionView: UICollectionView, atIndexPath : NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("propertyInfoCollectionViewCellIdentifier", forIndexPath: atIndexPath) as! VRPropertyInfoCollectionViewCell
        
        return cell
    }
    
    func descriptionCell(collectionView: UICollectionView, atIndexPath : NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("descriptionCollectionViewCellIdentifier", forIndexPath: atIndexPath) as! VRDescriptionCollectionViewCell
        
        return cell
    }
    
    func sizeForCell(atIndex indexPath: NSIndexPath, collectionViewWidth : CGFloat) -> CGSize {
        if !UIDevice.iPad() {
            return sizeForCellOniPhone(atIndex: indexPath, collectionViewWidth: collectionViewWidth)
        } else {
            return sizeForCellOniPad(atIndex: indexPath, collectionViewWidth: collectionViewWidth)
        }
    }
    
    func sizeForCellOniPhone(atIndex indexPath: NSIndexPath, collectionViewWidth : CGFloat) -> CGSize {
        switch indexPath.row {
        case 0: return CGSizeMake(collectionViewWidth, 280)
        case 1: return CGSizeMake(collectionViewWidth, 194)
        default: return CGSizeMake(collectionViewWidth, 250)
        }
    }
    
    func sizeForCellOniPad(atIndex indexPath: NSIndexPath, collectionViewWidth : CGFloat) -> CGSize {
        switch indexPath.row {
        case 0: return CGSizeMake(collectionViewWidth, 420)
        case 1: return CGSizeMake(collectionViewWidth, 194)
        default: return CGSizeMake(collectionViewWidth, 250)
        }
    }

}
