//
//  TabProtocol.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 19..
//
//

import Foundation
import UIKit


//-------------------------------//
// MARK: - TabIndicatorProtocol
//-------------------------------//

public protocol TabIndicatorProtocol {
    var indicatorText:TabStateElement<NSAttributedString>? { get set }
    var indicatorBackgroundColor:TabStateElement<UIColor>! { get set }
    
    var indicatorOverlayViews:Array<TabStateElement<UIView>>? { get set }
    
    func updateTabIndicator()
}

extension TabIndicatorProtocol {
    public func updateTabIndicator() { debugPrint("called updateTabIndicator") }
}



//-------------------------------//
// MARK: - TabCellProtocol
//-------------------------------//

public protocol TabCellProtocol {
    var tabTextLabel:UILabel { get }
    var tabOverlayViews:Array<UIView>? { get }
    func updateTabCell()
}

extension TabCellProtocol {
    public var tabOverlayViews:Array<UIView>? { return nil }
    public func updateTabCell() { debugPrint("called updateTabCell") }
}



//-------------------------------//
// MARK: - TabItemProtocol
//-------------------------------//

public protocol TabItemProtocol {
    var tabTitle:NSAttributedString! { get set }
    var tabIdentifier:String!  { get set }
    var tabCellClazz:UICollectionViewCell.Type! { get set }
    var tabBackgroundColor:TabStateElement<UIColor>? { get set }
    
    
    var indicatorText:TabStateElement<NSAttributedString>? { get set }
    var indicatorBackgroundColor:TabStateElement<UIColor>? { get set }
    var indicatorOverlayViews:Array<TabStateElement<UIView>>? { get set }
    
    var padding:UIEdgeInsets { get }
}

extension TabItemProtocol {
    func isValidTabCell() -> Bool {
        guard let _ = tabCellClazz.init() as? TabCellProtocol else { return false }
        return true
    }
    
    public var itemMinimumWidth:CGFloat {
        return tabTitle.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                     options: [.usesLineFragmentOrigin],
                                     context: nil).size.width
    }
    
    public var padding:UIEdgeInsets { return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) }
    
    public var expectedWidth:CGFloat { return padding.left + itemMinimumWidth + padding.right }
}




//-------------------------------//
// MARK: - TabContainerDelegate
//-------------------------------//

public protocol TabContainerDelegate : class {
    
}
