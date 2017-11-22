//
//  TabCell.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 20..
//
//

import UIKit
import PGTabBar

open class TabCell: UICollectionViewCell, TabCellProtocol {
    
    public weak var container: TabContainer?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    lazy var titleLabel:UILabel = {
        let label = UILabel(frame: self.bounds)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var maskLabel:UILabel = {
        let label = UILabel(frame: self.bounds)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    public func updateTabCell(_ item: TabItemProtocol?) {
        guard let tabItem = item as? TabItem else { return }
        
        self.titleLabel.attributedText = tabItem.tabSelected ? tabItem.selectedTitle : tabItem.title
    }
}

extension TabCell {
    public func setup() {
        backgroundColor = .white
        contentView.addSubview(titleLabel)
        
        let top      = NSLayoutConstraint(item: titleLabel, attribute: .top,      relatedBy: .equal, toItem: contentView, attribute: .top,      multiplier: 1, constant: 0)
        let bottom   = NSLayoutConstraint(item: titleLabel, attribute: .bottom,   relatedBy: .equal, toItem: contentView, attribute: .bottom,   multiplier: 1, constant: 0)
        let leading  = NSLayoutConstraint(item: titleLabel, attribute: .leading,  relatedBy: .equal, toItem: contentView, attribute: .leading,  multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
        
        let innerConstraints = [top, bottom, leading, trailing]
        
        self.backgroundColor = .yellow
        
        self.addConstraints(innerConstraints)
        
        self.setNeedsUpdateConstraints()
        
    }
}
