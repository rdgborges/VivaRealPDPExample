//
//  VRPropertyDetailsCollectionViewLayout.swift
//  VivaRealPropertyDetails
//
//  Created by Rodrigo Soares on 25/01/16.
//  Copyright © 2016 VivaReal. All rights reserved.
//

import UIKit

protocol VRPropertyDetailsCollectionViewLayoutDelegate {
    
    func collectionView(collectionView:UICollectionView, heightForItemAtIndexPath indexPath:NSIndexPath,
        withWidth:CGFloat) -> CGFloat
}

class VRPropertyDetailsCollectionViewLayout: UICollectionViewLayout {
    
    var delegate: VRPropertyDetailsCollectionViewLayoutDelegate!
    
    var numberOfColumns = 1
    var cellPadding: CGFloat = 0.0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override func prepareLayout() {
        
        updateColumnsBasedOnScreen()
        
        cache = []
        
        contentHeight = 0.0
        
        // configure first view
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        
        let itemHeight = delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath, withWidth: contentWidth)
        let finalHeight = itemHeight + cellPadding * 2
        
        let frame = CGRect(x: 0, y: 0, width: contentWidth, height: finalHeight)
        let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
        
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
        
        contentHeight = max(contentHeight, CGRectGetMaxY(frame))
        
        // configure other views
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: contentHeight)
        
        for item in 1 ..< collectionView!.numberOfItemsInSection(0) {
            
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            
            let width = columnWidth - cellPadding * 2
            
            let itemHeight = delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath, withWidth: width)
            let finalHeight = itemHeight + cellPadding * 2
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: finalHeight)
            let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, CGRectGetMaxY(frame))
            yOffset[column] = yOffset[column] + finalHeight
            
            column = column >= (numberOfColumns - 1) ? 0 : ++column
            
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    func updateColumnsBasedOnScreen() {
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        if orientation == UIInterfaceOrientation.Portrait || orientation == UIInterfaceOrientation.PortraitUpsideDown {
            // portrait
            self.numberOfColumns = 1
            
        } else {
            // landscape
            let horizontalSizeClass = self.collectionView?.traitCollection.horizontalSizeClass
            let verticalSizeClass = self.collectionView?.traitCollection.verticalSizeClass
            
            if horizontalSizeClass == UIUserInterfaceSizeClass.Regular && verticalSizeClass == UIUserInterfaceSizeClass.Regular {
                let applicationDelegate = UIApplication.sharedApplication().delegate
                let isFullScreen = CGRectEqualToRect(applicationDelegate!.window!!.frame, applicationDelegate!.window!!.screen.bounds)
                
                if isFullScreen {
                    self.numberOfColumns = 2
                } else {
                    self.numberOfColumns = 1
                }
            } else {
                self.numberOfColumns = 1
                
            }
            
        }
    }
    
}
