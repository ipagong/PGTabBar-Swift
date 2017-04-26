//
//  ViewController.swift
//  PGTabBar
//
//  Created by damon.park on 04/19/2017.
//  Copyright (c) 2017 damon.park. All rights reserved.
//

import UIKit
import PGTabBar

class ViewController: UIViewController {
    
    @IBOutlet weak var tabContainer: TabContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabContainer.option.bounces = true
        
        tabContainer.option.fitable = true
        //        TabContainer.option.fitable = false
        
        var tabList = [TabItem]()
        
        tabList.append(TabItem(title: TabText.title("A").attrText, cellClazz: MyTabCell.self ))
        tabList.append(TabItem(title: TabText.title("AAAAA").attrText, cellClazz: MyTabCell.self ))
        tabList.append(TabItem(title: TabText.title("B").attrText, cellClazz: MyTabCell.self ))
        tabList.append(TabItem(title: TabText.title("BB").attrText, cellClazz: MyTabCell.self ))
        tabList.append(TabItem(title: TabText.title("BBBBB").attrText, cellClazz: MyTabCell.self ))
        tabList.append(TabItem(title: TabText.title("C").attrText, cellClazz: MyTabCell.self ))
        tabList.append(TabItem(title: TabText.title("CCC").attrText, cellClazz: MyTabCell.self ))
        tabList.append(TabItem(title: TabText.title("CCCCC").attrText, cellClazz: MyTabCell.self ))

        tabContainer.tabList = tabList
        
    }

}

class MyTabCell: TabCell {
    
}
