//
//  ViewController.swift
//  PGTabBar
//
//  Created by damon.park on 04/19/2017.
//  Copyright (c) 2017 damon.park. All rights reserved.
//

import UIKit
import PGTabBar

class ViewController: UIViewController, TabContainerDelegate {
    @IBOutlet weak var tabContainer: TabContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabContainer.indicator = TabIndicator()
        tabContainer.option.bounces = false
        tabContainer.delegate = self
//        tabContainer.option.interItemSpacing = 3
//        tabContainer.option.lineSpacing = 1
        
        tabContainer.option.aspect = .fitable
        tabContainer.option.alignment = .center
        
        var tabList = [TabItem]()
        
        tabList.append(TabItem(title: TabText.title("YouTube").boldFont(size: 18).attrText,
                               selectedTitle: TabText.title("YouTube").boldFont(size: 18).color(.red).attrText,
                               cellClazz: TabCell.self ))
        tabList.append(TabItem(title: TabText.title("Facebook").boldFont(size: 18).attrText,
                               selectedTitle: TabText.title("Facebook").boldFont(size: 18).color(.red).attrText,
                               cellClazz: TabCell.self ))
        tabList.append(TabItem(title: TabText.title("A").boldFont(size: 18).attrText,
                               selectedTitle: TabText.title("A").boldFont(size: 18).color(.red).attrText,
                               cellClazz: TabCell.self ))
        tabList.append(TabItem(title: TabText.title("Na").boldFont(size: 18).attrText,
                               selectedTitle: TabText.title("Na").boldFont(size: 18).color(.red).attrText,
                               cellClazz: TabCell.self ))
//        tabList.append(TabItem(title: TabText.title("Instagram").boldFont(size: 18).attrText,
//                               selectedTitle: TabText.title("Instagram").boldFont(size: 18).color(.red).attrText,
//                               cellClazz: TabCell.self ))
//        tabList.append(TabItem(title: TabText.title("Twitch").boldFont(size: 18).attrText,
//                               selectedTitle: TabText.title("Twitch").boldFont(size: 18).color(.red).attrText,
//                               cellClazz: TabCell.self ))
//        tabList.append(TabItem(title: TabText.title("Pinterest").boldFont(size: 18).attrText,
//                               selectedTitle: TabText.title("Pinterest").boldFont(size: 18).color(.red).attrText,
//                               cellClazz: TabCell.self ))

        tabContainer.tabList = tabList
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tabContainer.setNeedsUpdateConstraints()
    }

/*
    func indexWithTabContainer(_ container:TabContainer) -> NSInteger? {
        return 0
    }
    
    func didSelectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol) {
        
    }
    
    func didDeselectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol) {
        
    }
 */

}
