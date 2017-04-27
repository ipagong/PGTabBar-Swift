//
//  TabCell.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 20..
//
//

import UIKit

open class TabCell: UICollectionViewCell, TabCellProtocol {
    
    public weak var option: TabContainer.TabOption?
    
    public var tabIcon: UIImage?
    public var tabTextLabel: UILabel { return self.tabLabel }
    public var tabOverlayView: TabStateElement<UIView>?
    
    private var innerConstraints:[NSLayoutConstraint]?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    lazy var tabLabel:UILabel = {
        let label = UILabel(frame: self.bounds)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    public func updateTabCell() {
        if innerConstraints == nil {
            let top      = NSLayoutConstraint(item: tabLabel, attribute: .top,      relatedBy: .equal, toItem: contentView, attribute: .top,      multiplier: 1, constant: 0)
            let bottom   = NSLayoutConstraint(item: tabLabel, attribute: .bottom,   relatedBy: .equal, toItem: contentView, attribute: .bottom,   multiplier: 1, constant: 0)
            let leading  = NSLayoutConstraint(item: tabLabel, attribute: .leading,  relatedBy: .equal, toItem: contentView, attribute: .leading,  multiplier: 1, constant: 0)
            let trailing = NSLayoutConstraint(item: tabLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)
            innerConstraints = [top, bottom, leading, trailing]
            addConstraints(innerConstraints!)
            self.setNeedsUpdateConstraints()
        }
    }
}

extension TabCell {
    public func setup() {
        backgroundColor = .white
        contentView.addSubview(tabLabel)
        updateTabCell()
    }
}
