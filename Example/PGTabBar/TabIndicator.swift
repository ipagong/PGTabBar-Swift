//
//  TabIndicator.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 26..
//
//

import Foundation
import PGTabBar

open class TabIndicator:UIView, TabIndicatorProtocol {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - TabIndicatorProtocol
    public weak var container: TabContainer?
    
    public var selectedIndex:NSInteger = 0
    
    public func moveTo(cell:UICollectionViewCell, layout:UICollectionViewLayoutAttributes, item:TabItemProtocol, animated:Bool = false) {

        if self.superview == nil {
            cell.superview?.addSubview(self)
        }
        
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.frame = CGRect(x: layout.frame.origin.x + 4, y: layout.frame.height - 15, width: layout.frame.width - 8, height: 2)
        }
    }
    
    public func updateTabIndicator() {
        self.backgroundColor = .red
    }
}
