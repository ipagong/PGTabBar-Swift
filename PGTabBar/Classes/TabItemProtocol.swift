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
    
    var tabCellType:TabCellType! { get set }
    
    var tabIdentifier:String { get }
    
    var tabSelected:Bool { get set }
    
    var itemMinimumWidth:CGFloat { get }
    
    var padding:UIEdgeInsets { get }
    
    var expectedWidth:CGFloat { get }
    
}

extension TabItemProtocol {
    
    public func isValidTabCell() -> Bool {
        guard let _ = tabCellType.preloadForValidation() as? TabCellProtocol else { return false }
        return true
    }
    
    public var tabIdentifier:String {
        switch self.tabCellType! {
        case .clazz(let type):  return NSStringFromClass(type) as String
        case .nib(let nibName): return nibName
        }
    }
    
    public var itemMinimumWidth:CGFloat { return 80 }
    
    public var padding:UIEdgeInsets { return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) }
    
    public var expectedWidth:CGFloat { return padding.left + itemMinimumWidth + padding.right }
}

public enum TabCellType {
    case clazz(type: UICollectionViewCell.Type)
    case nib(nibName: String)
    
    func preloadForValidation() -> Any? {
        switch self {
        case .clazz(let type):
            return type.init()
        case .nib(let nibName):
            guard nibName.isEmpty == false else { return nil }
            return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first
        }
    }
    
    func registTabCell(_ collectionView:UICollectionView, tabIdentifier:String) {
        switch self {
        case .clazz(let type):
            collectionView.register(type, forCellWithReuseIdentifier: tabIdentifier)
            
        case .nib(let nibName):
            collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: tabIdentifier)
        }
    }
}

