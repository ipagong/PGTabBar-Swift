//
//  TabIndicator.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 26..
//
//

import Foundation

open class TabIndicator:UIView, TabIndicatorProtocol {
    
    public weak var option: TabContainer.TabOption?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateTabIndicator()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.updateTabIndicator()
    }

    //MARK: - TabIndicatorProtocol
    
    public var selectedIndex:NSInteger = NSNotFound
    
    public func moveTo(cell:UICollectionViewCell, layout:UICollectionViewLayoutAttributes, item:TabItemProtocol, animated:Bool = false) {
        
        cell.superview?.addSubview(self)
        
        UIView.animate(withDuration: (animated ? 0.3 : 0)) { _ in self.frame = layout.frame }
    }
    
    public func updateTabIndicator() {
        backgroundColor = .yellow
    }
}
