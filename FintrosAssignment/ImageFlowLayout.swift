////
////  ImageFlowLayout.swift
////  FintrosAssignment
////
////  Created by Minhung Ling on 2017-05-16.
////  Copyright © 2017 Minhung Ling. All rights reserved.
////
//
//import UIKit
//
//class ImageFlowLayout: UICollectionViewFlowLayout {
//    override var collectionViewContentSize: CGSize {
//        let count = collectionView!.dataSource!.collectionView(collectionView!, numberOfItemsInSection: 0)
//        let canvasSize: CGSize = collectionView!.frame.size
//        var contentSize = canvasSize
//
//        // Only support single section for now.
//    // Only support Horizontal scroll
//    let rowCount = (canvasSize.height - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1;
//    let columnCount = (canvasSize.width - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1;
//    let page = CGFloat(ceilf(Float(CGFloat(count) / CGFloat((rowCount * columnCount)))))
//    contentSize.width = page * canvasSize.width;
//    
//    return contentSize;
//    }
//    
//    
//    - (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath
//    {
//    CGSize canvasSize = self.collectionView.frame.size;
//    
//    NSUInteger rowCount = (canvasSize.height - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1;
//    NSUInteger columnCount = (canvasSize.width - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1;
//    
//    CGFloat pageMarginX = (canvasSize.width - columnCount * self.itemSize.width - (columnCount > 1 ? (columnCount - 1) * self.minimumLineSpacing : 0)) / 2.0f;
//    CGFloat pageMarginY = (canvasSize.height - rowCount * self.itemSize.height - (rowCount > 1 ? (rowCount - 1) * self.minimumInteritemSpacing : 0)) / 2.0f;
//    
//    NSUInteger page = indexPath.row / (rowCount * columnCount);
//    NSUInteger remainder = indexPath.row - page * (rowCount * columnCount);
//    NSUInteger row = remainder / columnCount;
//    NSUInteger column = remainder - row * columnCount;
//    
//    CGRect cellFrame = CGRectZero;
//    cellFrame.origin.x = pageMarginX + column * (self.itemSize.width + self.minimumLineSpacing);
//    cellFrame.origin.y = pageMarginY + row * (self.itemSize.height + self.minimumInteritemSpacing);
//    cellFrame.size.width = self.itemSize.width;
//    cellFrame.size.height = self.itemSize.height;
//    
//    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal)
//    {
//    cellFrame.origin.x += page * canvasSize.width;
//    }
//    
//    return cellFrame;
//    }
//    
//    - (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//    {
//    UICollectionViewLayoutAttributes * attr = [super layoutAttributesForItemAtIndexPath:indexPath];
//    attr.frame = [self frameForItemAtIndexPath:indexPath];
//    return attr;
//    }
//    
//    - (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//    {
//    NSArray * originAttrs = [super layoutAttributesForElementsInRect:rect];
//    NSMutableArray * attrs = [NSMutableArray array];
//    
//    [originAttrs enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * attr, NSUInteger idx, BOOL *stop) {
//    NSIndexPath * idxPath = attr.indexPath;
//    CGRect itemFrame = [self frameForItemAtIndexPath:idxPath];
//    if (CGRectIntersectsRect(itemFrame, rect))
//    {
//    attr = [self layoutAttributesForItemAtIndexPath:idxPath];
//    [attrs addObject:attr];
//    }
//    }];
//    
//    return attrs;
//    }
//}
