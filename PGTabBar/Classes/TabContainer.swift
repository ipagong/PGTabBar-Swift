//
//  TabContainer.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 20..
//
//

import UIKit

public class TabContainer: UIView {
    
    public weak var delegate:TabContainerDelegate?
    
    public var option:TabOption = TabOption()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContainer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupContainer()
    }
    
    fileprivate lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = false
        collectionView.bounces = true
        return collectionView
    }()
    
    fileprivate lazy var flowLayout:UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    
    public var tabList:Array<TabItemProtocol>? {
        didSet {
            self.validTabList = self.tabList?.filter { $0.isValidTabCell() }
            self.tabTotalWidth = self.tabList?.reduce(0) { $0 + $1.padding.left + floor($1.itemMinimumWidth) + $1.padding.right } ?? 0
            self.reloadData()
        }
    }
    
    fileprivate var validTabList:Array<TabItemProtocol>?
    fileprivate var tabTotalWidth:CGFloat = 0
}

extension TabContainer: UICollectionViewDelegate {
    
}

extension TabContainer: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return validTabList?.count ?? 0
    }
    
    public  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = self.tabList?[indexPath.row] else { return TabCell() }
        
        let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: item.tabIdentifier, for: indexPath) as UICollectionViewCell
        
        if let tabType = tabCell as? TabCellProtocol {
            tabType.tabTextLabel.attributedText = item.tabTitle
            tabType.updateTabCell()
        }
        
        return tabCell
    }
}

extension TabContainer: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = self.tabList?[indexPath.row] else { return .zero }
        
        guard option.fitable == true else { return CGSize(width: item.expectedWidth, height: self.bounds.height) }
        
        let extraWidth:CGFloat = (self.bounds.width - self.tabTotalWidth)
        
        guard extraWidth > 0 else { return CGSize(width: item.expectedWidth, height: self.bounds.height) }
        
        let extra = (extraWidth / CGFloat(self.tabList!.count))
        
        return CGSize(width: item.expectedWidth + extra, height: self.bounds.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return option.lineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return option.interItemSpacing
    }
}

extension TabContainer {
    
    fileprivate func setupContainer(){
        self.addSubview(self.collectionView)
        option.collectionView = collectionView
    }
    
    fileprivate func setupConstraints() {
        let top      = NSLayoutConstraint(item: collectionView, attribute: .top,      relatedBy: .equal, toItem: self, attribute: .top,      multiplier: 1, constant: 0)
        let bottom   = NSLayoutConstraint(item: collectionView, attribute: .bottom,   relatedBy: .equal, toItem: self, attribute: .bottom,   multiplier: 1, constant: 0)
        let leading  = NSLayoutConstraint(item: collectionView, attribute: .leading,  relatedBy: .equal, toItem: self, attribute: .leading,  multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        addConstraints([top, bottom, leading, trailing])
    }
    
    fileprivate func reloadData() {
        guard let tabList = validTabList, tabList.count > 0 else { return }
        
        tabList
            .flatMap { ($0.tabCellClazz, $0.tabIdentifier) }
            .forEach { self.collectionView.register($0.0, forCellWithReuseIdentifier: $0.1) }
     
        self.collectionView.reloadData()
    }
}
