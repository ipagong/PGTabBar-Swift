//
//  TabIndicatorProtocol.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 28..
//
//

import Foundation


//-------------------------------------//
// MARK: - TabIndicatorProtocol
//-------------------------------------//

public protocol TabIndicatorProtocol {
    
    weak var container:TabContainer? { get set }
    
    var selectedIndex:NSInteger { get set }
    
    func moveTo(cell:UICollectionViewCell, layout:UICollectionViewLayoutAttributes, item:TabItemProtocol, animated:Bool)
    
    func updateTabIndicator()
    
}

extension TabIndicatorProtocol {
    
    public func updateTabIndicator() { debugPrint("called updateTabIndicator") }
    
}

