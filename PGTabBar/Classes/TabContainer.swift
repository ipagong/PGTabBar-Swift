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
    public var indicator:TabIndicatorProtocol = IndexIndicator() {
        didSet{ indicator.container = self }
    }
    
    public var currentIndex:NSInteger { return indicator.selectedIndex }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContainer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupContainer()
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.reloadData(animated: false)
        
        self.addTabConstraints()
    }
    
    fileprivate lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
    
    lazy var flowLayout:UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    public var tabList:Array<TabItemProtocol>? {
        set { self.setTabList(newValue) }
        get { return validTabList }
    }
    
    public func setTabList(_ tabList:Array<TabItemProtocol>?, animated:Bool = false, preferredIndex:Bool = false) {
        self.reloadData(animated: animated, preferredIndex: preferredIndex) { tabList }
    }
    
    public var reloaded:Bool = false
    
    fileprivate var validTabList:Array<TabItemProtocol>?
    fileprivate var minTotalWidth:CGFloat = 0
    fileprivate var expectedTotalWidth:CGFloat { return self.tabList?.reduce(0) { $0 + self.getSize($1).width } ?? 0 }
    fileprivate var preferredIndex:NSInteger { return delegate?.indexWithTabContainer(self) ?? 0 }
    fileprivate var selectAnimation:Bool = false
    
    fileprivate var top:NSLayoutConstraint?
    fileprivate var bottom:NSLayoutConstraint?
    fileprivate var leading:NSLayoutConstraint?
    fileprivate var trailing:NSLayoutConstraint?
    fileprivate var centerX:NSLayoutConstraint?
    fileprivate var width:NSLayoutConstraint?
}

extension TabContainer: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = self.validTabList?[indexPath.row] else { return }
        guard let cell = collectionView.cellForItem(at: indexPath), let tabCell = cell as? TabCellProtocol else { return }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        self.indicator.selectedKey = item.tabItemKey
        self.indicator.selectedIndex = indexPath.row
        self.indicator.updateTabIndicator()
        
        if let layout = collectionView.layoutAttributesForItem(at: indexPath) {
            self.indicator.moveTo(cell:cell, layout: layout, item: item, animated:selectAnimation)
        }
        
        tabCell.updateTabCell(item)
        
        delegate?.didSelectedTabContainer(self, index: indexPath.row, item: item, tabCell: tabCell)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let item = self.validTabList?[indexPath.row] else { return }
        guard let cell = collectionView.cellForItem(at: indexPath), let tabCell = cell as? TabCellProtocol else { return }
        
        self.indicator.selectedKey = ""
        
        tabCell.updateTabCell(item)
        
        delegate?.didDeselectedTabContainer(self, index: indexPath.row, item: item, tabCell: tabCell)
    }
}

extension TabContainer: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return validTabList?.count ?? 0
    }
    
    public  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = self.validTabList?[indexPath.row] else { return UICollectionViewCell() }
        
        let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: item.tabIdentifier, for: indexPath) as UICollectionViewCell
        
        if var tabType = tabCell as? TabCellProtocol {
            tabType.container = self
            tabType.updateTabCell(item)
        }
        
        if indexPath.row == self.indicator.selectedIndex, let layout = collectionView.layoutAttributesForItem(at: indexPath) {
            self.indicator.selectedKey = item.tabItemKey
            self.indicator.updateTabIndicator()
            self.indicator.moveTo(cell:tabCell, layout: layout, item: item, animated:false)
        }
        
        return tabCell
    }
}

extension TabContainer: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = self.validTabList?[indexPath.row] else { return .zero }
        return self.getSize(item)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return option.lineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return option.interItemSpacing
    }
}

//:MARK - private methods
extension TabContainer {
    
    fileprivate func setupContainer() {
        
        self.addSubview(self.collectionView)
        self.setupConstraints()
        self.addTabConstraints()
        
        option.collectionView = collectionView
        indicator = IndexIndicator()
        indicator.container = self
    }
    
    fileprivate func setupConstraints() {
        top      = NSLayoutConstraint(item: collectionView, attribute: .top,      relatedBy: .equal, toItem: self, attribute: .top,      multiplier: 1, constant: 0)
        bottom   = NSLayoutConstraint(item: collectionView, attribute: .bottom,   relatedBy: .equal, toItem: self, attribute: .bottom,   multiplier: 1, constant: 0)
        leading  = NSLayoutConstraint(item: collectionView, attribute: .leading,  relatedBy: .equal, toItem: self, attribute: .leading,  multiplier: 1, constant: 0)
        trailing = NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        centerX  = NSLayoutConstraint(item: collectionView, attribute: .centerX,  relatedBy: .equal, toItem: self, attribute: .centerX,  multiplier: 1, constant: 0)
        width    = NSLayoutConstraint(item: collectionView, attribute: .width,    relatedBy: .equal, toItem: nil,  attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        self.addConstraints([top!, bottom!, leading!, trailing!])
    }
    
    fileprivate func addTabConstraints() {
        self.removeConstraints([top!, bottom!, leading!, trailing!, centerX!])
        self.collectionView.removeConstraint(width!)
        
        let expectWidth = self.expectedTotalWidth
        
        guard bounds.width > expectWidth else {
            self.addConstraints([top!, bottom!, leading!, trailing!])
            return
        }
        
        self.width!.constant = expectWidth
        
        self.collectionView.addConstraint(width!)
        self.addConstraints([top!, bottom!])
        
        switch option.alignment {
        case .left:   self.addConstraint(leading!)
        case .right:  self.addConstraint(trailing!)
        case .center: self.addConstraint(centerX!)
        }
    }
    
    fileprivate func fitableItemSize(_ item: TabItemProtocol) -> CGSize {
        
        let extraWidth:CGFloat = (self.bounds.width - self.minTotalWidth - (CGFloat(self.validTabList!.count) * self.option.interItemSpacing))
        
        guard extraWidth > 0 else {
            return CGSize(width: floor(item.expectedWidth), height: self.bounds.height)
        }
        
        let extra = (extraWidth / CGFloat(self.validTabList!.count))
        
        return CGSize(width: item.expectedWidth + extra, height: self.bounds.height)
    }
    
    fileprivate func equalbeItemSize(_ item: TabItemProtocol) -> CGSize {
        let width = self.validTabList!.reduce(0.0, { max($0, floor($1.expectedWidth)) })
        return CGSize(width: width, height: self.bounds.height)
    }
    
    fileprivate func expectItemSize(_ item: TabItemProtocol) -> CGSize {
        return CGSize(width: floor(item.expectedWidth), height: self.bounds.height)
    }
    
    fileprivate func getSize(_ item: TabItemProtocol) -> CGSize {
        switch option.aspect {
        case .fitable: return fitableItemSize(item)
        case .equalbe: return equalbeItemSize(item)
        case .minimum: return expectItemSize(item)
        }
    }
}

//:MARK - public methods
extension TabContainer {
    
    public func reloadData(animated:Bool = false, preferredIndex:Bool = false, _ tabListClosure:() -> (Array<TabItemProtocol>?)) {
        let tabList = tabListClosure()
        self.validTabList = tabList?.filter { $0.isValidTabCell() }
        self.minTotalWidth = tabList?.reduce(0) { $0 + $1.padding.left + floor($1.itemMinimumWidth) + $1.padding.right } ?? 0
        self.addTabConstraints()
        self.reloadData(animated: animated, preferredIndex: preferredIndex)
    }
    
    public func reloadData(animated:Bool = false, preferredIndex:Bool = false) {
        
        self.reloaded = true
        
        validTabList?
            .flatMap { ($0.tabCellType, $0.tabIdentifier) }
            .forEach { $0.0.registTabCell(collectionView, tabIdentifier: $0.1) }
        
        let tabCount = validTabList?.count ?? 0
        
        var reloadIndex = (preferredIndex ? self.preferredIndex : self.indicator.selectedIndex)
        
        reloadIndex = max(min(tabCount - 1, reloadIndex), 0)
        
        self.indicator.selectedIndex = reloadIndex
        
        self.delegate?.didLoadTabContainer(self, tabCount: tabCount)
        
        self.collectionView.reloadData()
        
        guard tabCount > 0 else {
            self.reloaded = false
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { self.selectAt(reloadIndex, animated: animated) })
    }
    
    public func selectAt(_ index:NSInteger, animated:Bool = true) {
        self.selectAnimation = animated
        self.reloaded = true
        self.collectionView.selectItem(at: index.indexPath(), animated: animated, scrollPosition: .centeredHorizontally)
        self.collectionView.delegate?.collectionView!(collectionView, didSelectItemAt: index.indexPath())
        self.selectAnimation = true
        self.reloaded = false
    }
}

