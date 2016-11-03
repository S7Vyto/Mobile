//
//  SVCalendarFlowLayout.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 18/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

public let SVCalendarHeaderView = "CalendarHeaderView"

enum SVCalendarFlowLayoutDirection {
    case vertical, horizontal
}

class SVCalendarFlowLayout: UICollectionViewFlowLayout {
    fileprivate var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    fileprivate var contentHeight: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.height - (insets.top + insets.bottom)
    }
    
    fileprivate let direction: SVCalendarFlowLayoutDirection!
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    fileprivate var width: CGFloat = 0.0
    fileprivate var height: CGFloat = 0.0
    
    var isAutoResizeCell: Bool = false
    
    var numberOfColumns: Int?
    var numberOfRows: Int?
    
    var columnWidth: CGFloat = 50.0
    var columnHeight: CGFloat = 50.0
    var cellPadding: CGFloat = 5.0
    
    // MARK: - FlowLayout LifeCycle
    init(direction: SVCalendarFlowLayoutDirection) {
        self.direction = direction
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        cache.removeAll()
    }
    
    override func prepare() {
        if cache.isEmpty {
            var index = 0
            var xOffset = [CGFloat]()
            var yOffset = [CGFloat]()
            
            if direction == .vertical {
                width = contentWidth
                
                if numberOfColumns == nil {
                    numberOfColumns = Int(width/columnWidth)
                }
                
                if isAutoResizeCell {
                    columnWidth = (contentWidth - CGFloat(numberOfColumns! - 1) * cellPadding) / CGFloat(numberOfColumns!)
                    columnHeight = columnWidth
                }
                
                let columnContent = CGFloat(numberOfColumns!) * (columnWidth - 2 * cellPadding)
                let columnOffset = (contentWidth - columnContent) / CGFloat(numberOfColumns! - 1) + 2.5
                                
                for column in 0 ..< numberOfColumns! {
                    xOffset += [columnWidth * CGFloat(column) + columnOffset]
                    yOffset += [0]
                }
            }
            else {
                height = contentHeight
                columnHeight = contentHeight
                
                xOffset += [0]
                yOffset += [0]
            }
            
            let itemWidth = columnWidth - 2 * cellPadding
            let itemHeight = columnHeight - 2 * cellPadding
            
            for section in 0 ..< collectionView!.numberOfSections {
                for item in 0 ..< collectionView!.numberOfItems(inSection: section) {
                    let indexPath = IndexPath(item: item, section: section)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    
                    if direction == .vertical {
                        attributes.frame = CGRect(x: xOffset[index], y: yOffset[index], width: itemWidth, height: itemHeight)
                        height = max(height, attributes.frame.origin.y + itemHeight)
                        yOffset[index] = yOffset[index] + itemHeight
                        
                        if index >= numberOfColumns! - 1 {
                            index = 0
                        }
                        else {
                            index += 1
                        }
                    }
                    else {
                        attributes.frame = CGRect(x: xOffset[item], y: yOffset[0], width: itemWidth, height: itemHeight)
                        width = max(width, attributes.frame.origin.x + itemWidth)
                        xOffset += [xOffset[index] + itemWidth + 5.0]
                        index += 1
                    }
                    
                    cache.append(attributes)
                }
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: width, height: height)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return !self.collectionView!.bounds.equalTo(newBounds)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = [UICollectionViewLayoutAttributes]()
        for attr in cache {
            guard attr.frame.intersects(rect) else {
                continue
            }
            
            attrs.append(attr)
        }
        
        return attrs
    }
}
