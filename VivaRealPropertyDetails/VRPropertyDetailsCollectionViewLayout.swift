//
//  VRPropertyDetailsCollectionViewLayout.swift
//  VivaRealPropertyDetails
//
//  Created by Rodrigo Soares on 25/01/16.
//  Copyright © 2016 VivaReal. All rights reserved.
//

import UIKit

protocol VRPropertyDetailsCollectionViewLayoutDelegate {
    func heightForItemAtIndexPath(indexPath: NSIndexPath, withWidth:CGFloat) -> CGFloat
}

class VRPropertyDetailsCollectionViewLayout: UICollectionViewLayout {
    
    var delegate: VRPropertyDetailsCollectionViewLayoutDelegate!
    
    private var attributesCache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override func prepareLayout() {
        
        let numberOfColumns = columnsBasedOnScreen()
        attributesCache = []
        contentHeight = 0.0
        
        // Initializes offsets arrays
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
        
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        
        for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
            
            // Calculates cell frame
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let itemHeight = delegate.heightForItemAtIndexPath(indexPath, withWidth: columnWidth)
            
            var frame: CGRect
            if item == 0 {
                // if first cell, cell width == content width
                frame = CGRect(x: xOffset[column], y: yOffset[column], width: contentWidth, height: itemHeight)
            } else {
                // cell width == column width
                frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: itemHeight)
            }
            
            // Append cell attributes to cache
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attributes.frame = frame
            attributesCache.append(attributes)
            
            // Updates contentHeight
            contentHeight = max(contentHeight, CGRectGetMaxY(frame))
            
            // Updates y position of next cell
            if item == 0 {
                for i in 0..<yOffset.count {
                    yOffset[i] = itemHeight
                }
            } else {
                yOffset[column] = yOffset[column] + itemHeight
            }
            
            // Determines column where next cell will be placed
            if item == 0 {
                column = 0
            } else {
                column = column >= (numberOfColumns - 1) ? 0 : ++column
            }
            
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in attributesCache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    func columnsBasedOnScreen() -> Int {
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        if orientation == UIInterfaceOrientation.Portrait || orientation == UIInterfaceOrientation.PortraitUpsideDown {
            // portrait
            return 1
            
        } else {
            // landscape
            let horizontalSizeClass = self.collectionView?.traitCollection.horizontalSizeClass
            let verticalSizeClass = self.collectionView?.traitCollection.verticalSizeClass
            
            if horizontalSizeClass == UIUserInterfaceSizeClass.Regular && verticalSizeClass == UIUserInterfaceSizeClass.Regular {
                let applicationDelegate = UIApplication.sharedApplication().delegate
                
                guard let delegate = applicationDelegate else {
                    return 1
                }
                
                guard let window = delegate.window else {
                    return 1
                }
                
                let isFullscreen = CGRectEqualToRect(window!.frame, window!.screen.bounds)
                
                if isFullscreen {
                    return 2
                } else {
                    return 1
                }
            } else {
                return 1
            }
            
        }
    }
    
}
