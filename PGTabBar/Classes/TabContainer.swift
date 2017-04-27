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
    public var indicator:TabIndicatorProtocol? {
        didSet{ indicator?.option = option }
    }
    
    public var currentIndex:NSInteger { return indicator?.selectedIndex ?? NSNotFound }
    
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
        didSet {
            self.validTabList = self.tabList?.filter { $0.isValidTabCell() }
            self.tabTotalWidth = self.tabList?.reduce(0) { $0 + $1.padding.left + floor($1.itemMinimumWidth) + $1.padding.right } ?? 0
            self.reloadData()
        }
    }
    
    fileprivate var validTabList:Array<TabItemProtocol>?
    fileprivate var tabTotalWidth:CGFloat = 0
    fileprivate var preferredIndex:NSInteger { return delegate?.indexWithTabContainer(self) ?? 0 }
    
    fileprivate var top:NSLayoutConstraint?
    fileprivate var bottom:NSLayoutConstraint?
    fileprivate var leading:NSLayoutConstraint?
    fileprivate var trailing:NSLayoutConstraint?
    fileprivate var width:NSLayoutConstraint?
}

extension TabContainer: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = self.validTabList?[indexPath.row] else { return }
        guard let cell = collectionView.cellForItem(at: indexPath), let tabCell = cell as? TabCellProtocol else { return }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.didSelectedTabContainer(self, index: indexPath.row, item: item, tabCell: tabCell)
        
        guard let layout = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        
        self.indicator?.selectedIndex = indexPath.row
        self.indicator?.moveTo(cell:cell, layout: layout, item: item, animated:true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let item = self.validTabList?[indexPath.row] else { return }
        guard let cell = collectionView.cellForItem(at: indexPath), let tabCell = cell as? TabCellProtocol else { return }
        
        delegate?.didDeselectedTabContainer(self, index: indexPath.row, item: item, tabCell: tabCell)
    }
}

extension TabContainer: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return validTabList?.count ?? 0
    }
    
    public  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = self.validTabList?[indexPath.row] else { return TabCell() }
        
        let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: item.tabIdentifier, for: indexPath) as UICollectionViewCell
        
        if var tabType = tabCell as? TabCellProtocol {
            tabType.option = option
            tabType.tabTextLabel.attributedText = item.tabTitle
            tabType.updateTabCell()
        }
        
        return tabCell
    }
}

extension TabContainer: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = self.validTabList?[indexPath.row] else { return .zero }
        
        guard option.aspect == .fitable else { return CGSize(width: item.expectedWidth, height: self.bounds.height) }
        
        let extraWidth:CGFloat = (self.bounds.width - self.tabTotalWidth)
        
        guard extraWidth > 0 else { return CGSize(width: item.expectedWidth, height: self.bounds.height) }
        
        let extra = (extraWidth / CGFloat(self.validTabList!.count))
        
        return CGSize(width: item.expectedWidth + extra, height: self.bounds.height)
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
        
        option.collectionView = collectionView
        indicator?.option = option
    }
    
    fileprivate func setupConstraints() {
        top      = NSLayoutConstraint(item: collectionView, attribute: .top,      relatedBy: .equal, toItem: self, attribute: .top,      multiplier: 1, constant: 0)
        bottom   = NSLayoutConstraint(item: collectionView, attribute: .bottom,   relatedBy: .equal, toItem: self, attribute: .bottom,   multiplier: 1, constant: 0)
        leading  = NSLayoutConstraint(item: collectionView, attribute: .leading,  relatedBy: .equal, toItem: self, attribute: .leading,  multiplier: 1, constant: 0)
        trailing = NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        addConstraints([top!, bottom!, leading!, trailing!])
    }
    
    public override func updateConstraints() {
        super.updateConstraints()
        self.reloadData(animated: false)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadData(animated: false)
    }
    
}

//:MARK - public methods
extension TabContainer {
    
    public func reloadData(animated:Bool? = false) {
        guard let _ = validTabList, validTabList!.count > 0 else { return }
        
        validTabList!
            .flatMap { ($0.tabCellClazz, $0.tabIdentifier) }
            .forEach { self.collectionView.register($0.0, forCellWithReuseIdentifier: $0.1) }
        
        let reloadIndex = (self.indicator?.selectedIndex == NSNotFound ? self.preferredIndex : self.indicator?.selectedIndex)
        
        self.collectionView.performBatchUpdates({ self.collectionView.reloadData() }) { _ in self.selectAt(reloadIndex!, animated: animated!) }
    }
    
    public func selectAt(_ index:NSInteger, animated:Bool? = true) {
        guard let _ = validTabList, validTabList!.count > 0  else { return }
        
        let indexRow = max(min(self.validTabList!.count - 1, index), 0)
        
        guard let item = validTabList?[indexRow] else { return }
        
        let indexPath = indexRow.indexPath()
        
        guard let layout = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        self.indicator?.selectedIndex = indexPath.row
        self.indicator?.moveTo(cell:cell, layout: layout, item: item , animated:animated!)
        
    }
}

