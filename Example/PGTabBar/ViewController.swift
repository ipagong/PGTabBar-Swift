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
        
        tabContainer.option.bounces = true
        tabContainer.indicator = TabIndicator()
        tabContainer.delegate = self
        
//        tabContainer.option.aspect = .minimum // .fitable
        
        var tabList = [TabItem]()
        
        tabList.append(TabItem(title: TabText.title("YouTube").boldFont(size: 18).attrText, cellClazz: MyTabCell.self ))
//        tabList.append(TabItem(title: TabText.title("Facebook").boldFont(size: 18).attrText, cellClazz: MyTabCell.self ))
//        tabList.append(TabItem(title: TabText.title("Instagram").boldFont(size: 18).attrText, cellClazz: MyTabCell.self ))
        tabList.append(TabItem(title: TabText.title("Twitch").boldFont(size: 18).attrText, cellClazz: MyTabCell.self ))
        tabList.append(TabItem(title: TabText.title("Pinterest").boldFont(size: 18).attrText, cellClazz: MyTabCell.self ))

        tabContainer.tabList = tabList
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tabContainer.setNeedsUpdateConstraints()
    }

//    func indexWithTabContainer(_ container:TabContainer) -> NSInteger? {
//        return 0
//    }
    
//    func didSelectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol) {
//        
//    }
//    
//    func didDeselectedTabContainer(_ container:TabContainer, index:NSInteger, item:TabItemProtocol, tabCell:TabCellProtocol) {
//        
//    }

}



class MyTabCell: TabCell {
    
}
