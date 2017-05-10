//
//  TabOption.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 27..
//
//

import Foundation

extension TabContainer {
    public class TabOption {
        
        weak var collectionView:UICollectionView?
        
        public var aspect:AspectMode = .fitable
        
        public var alignment:Alignment = .left
        
        public var lineSpacing:CGFloat = 0
        
        public var interItemSpacing:CGFloat = 0
        
        public var animation:Bool = true
        
        public var alwaysBounce:Bool = false { didSet { collectionView?.alwaysBounceHorizontal = alwaysBounce } }
        
        public var bounces:Bool = true { didSet { collectionView?.bounces = bounces } }
        
    }

    public enum AspectMode: Int {
        case fitable
        case equalbe
        case minimum
    }

    public enum Alignment: Int {
        case left
        case center
        case right
    }
}

