//
//  TabProtocol.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 19..
//
//

import Foundation
import UIKit


//-------------------------------------//
// MARK: - TabIndicatorProtocol
//-------------------------------------//

public protocol TabIndicatorProtocol {
    weak var option:TabContainer.TabOption? { get set }
    
    var selectedIndex:NSInteger { get set }
    
    func updateTabIndicator()
    
    func moveTo(cell:UICollectionViewCell, layout:UICollectionViewLayoutAttributes, item:TabItemProtocol, animated:Bool)
}

extension TabIndicatorProtocol {
    public func updateTabIndicator() { debugPrint("called updateTabIndicator") }
}

//-------------------------------------//
// MARK: - TabCellProtocol
//-------------------------------------//

public protocol TabCellProtocol {
    weak var option:TabContainer.TabOption? { get set }
    
    var tabTextLabel:UILabel { get }
    
    var tabIcon:UIImage? { get set }
    
    var tabOverlayView:TabStateElement<UIView>? { get }
    
    func updateTabCell()
}

extension TabCellProtocol {
    public var tabOverlayViews:TabStateElement<UIView>? { return nil }
    
    public func updateTabCell() { debugPrint("called updateTabCell") }
}



//-------------------------------------//
// MARK: - TabItemProtocol
//-------------------------------------//

public protocol TabItemProtocol {
    var tabTitle:NSAttributedString? { get set }
    
    var tabIdentifier:String!  { get set }
    
    var tabIcon:UIImage? { get set }
    
    var tabCellClazz:UICollectionViewCell.Type! { get set }
    
    var tabBackgroundColor:TabStateElement<UIColor>? { get set }

    var padding:UIEdgeInsets { get }
    
    var expectedWidth:CGFloat { get }
}

extension TabItemProtocol {
    public func isValidTabCell() -> Bool {
        guard let _ = tabCellClazz.init() as? TabCellProtocol else { return false }
        return true
    }
    
    public var itemMinimumWidth:CGFloat {
        return tabTitle!.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                     options: [.usesLineFragmentOrigin],
                                     context: nil).size.width
    }
    
    public var padding:UIEdgeInsets { return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) }
    
    public var expectedWidth:CGFloat { return padding.left + itemMinimumWidth + padding.right }
}




//-------------------------------------//
// MARK: - TabContainerDelegate
//-------------------------------------//

public protocol TabContainerDelegate : class {
    func indexWithTabContainer(_ container:TabContainer) -> NSInteger?
    
    func willSelectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol)
    
    func didSelectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol)
    
    func willDeselectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol)
    
    func didDeselectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol)
}


extension TabContainerDelegate {
    public func indexWithTabContainer(_ container:TabContainer) -> NSInteger? { return nil }
    
    public func willSelectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol)   { }
    
    public func willDeselectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol) { }
    
    public func didSelectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol)    { }
    
    public func didDeselectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol)  { }
}



