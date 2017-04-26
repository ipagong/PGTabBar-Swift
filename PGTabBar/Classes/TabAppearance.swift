//
//  TabAppearance.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 25..
//
//

import Foundation

extension TabContainer {
    public class TabOption {
        weak var collectionView:UICollectionView?
        
        public var fitable:Bool = false
        public var lineSpacing:CGFloat = 0
        public var interItemSpacing:CGFloat = 0
        
        public var alwaysBounce:Bool = false { didSet { collectionView?.alwaysBounceHorizontal = alwaysBounce } }
        public var bounces:Bool = true { didSet { collectionView?.bounces = bounces } }
        
        public var tab:TabAppearance = TabAppearance()
        public var indicator:IndicatorAppearance = IndicatorAppearance()
    }
    
    public struct TabAppearance {
        public var backgroundColor:TabStateElement<UIColor> = TabStateElement(common: .white)
    }
    
    public struct IndicatorAppearance {
        public var textColor:TabStateElement<UIColor> = TabStateElement(common: .black)
        public var backgroundColor:TabStateElement<UIColor> = TabStateElement(common: .yellow)
    }
}

