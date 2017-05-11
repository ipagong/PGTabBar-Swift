//
//  TabItemProtocol.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 28..
//
//

import Foundation

//-------------------------------------//
// MARK: - TabItemProtocol
//-------------------------------------//

public protocol TabItemProtocol {
    
    var tabItemKey:String!  { get set }
    
    var tabCellClazz:UICollectionViewCell.Type! { get set }
    
    var tabIdentifier:String { get }
    
    var itemMinimumWidth:CGFloat { get }
    
    var padding:UIEdgeInsets { get }
    
    var expectedWidth:CGFloat { get }
}

extension TabItemProtocol {
    
    public func isValidTabCell() -> Bool {
        guard let _ = tabCellClazz.init() as? TabCellProtocol else { return false }
        return true
    }
    
    public var tabIdentifier:String {
        guard tabCellClazz != nil else { return "TabCell" }
        return NSStringFromClass(tabCellClazz) as String
    }
    
    public var itemMinimumWidth:CGFloat { return 80 }
    
    public var padding:UIEdgeInsets { return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) }
    
    public var expectedWidth:CGFloat { return padding.left + itemMinimumWidth + padding.right }
}


