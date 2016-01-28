//
//  VRCollectionViewDelegate.swift
//  VivaRealPropertyDetails
//
//  Created by Rodrigo Soares on 25/01/16.
//  Copyright © 2016 VivaReal. All rights reserved.
//

import UIKit

class VRCollectionViewDelegate: NSObject, UICollectionViewDelegate {

    
    func sizeForCell(collectionView: UICollectionView, collectionViewWidth : CGFloat, atIndex : NSIndexPath) -> CGSize {
        
        if !UIDevice.iPad() {
            return sizeForCellOniPhone(collectionView, collectionViewWidth: collectionViewWidth, atIndex: atIndex)
        } else {
            return sizeForCellOniPad(collectionView, collectionViewWidth: collectionViewWidth, atIndex: atIndex)
        }
    }
    
    func sizeForCellOniPhone(collectionView: UICollectionView, collectionViewWidth : CGFloat, atIndex : NSIndexPath) -> CGSize {
        switch atIndex.row {
        case 0: return CGSizeMake(collectionViewWidth, 280)
        case 1: return CGSizeMake(collectionViewWidth, 194)
        default: return CGSizeMake(collectionViewWidth, 250)
        }
        
    }
    
    func sizeForCellOniPad(collectionView: UICollectionView, collectionViewWidth : CGFloat, atIndex : NSIndexPath) -> CGSize {
        switch atIndex.row {
        case 0: return CGSizeMake(collectionViewWidth, 420)
        case 1: return CGSizeMake(collectionViewWidth, 194)
        default: return CGSizeMake(collectionViewWidth, 250)
        }
        
    }
}
