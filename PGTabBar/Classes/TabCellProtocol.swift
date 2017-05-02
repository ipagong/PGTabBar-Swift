//
//  TabCellProtocol.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 28..
//
//

import Foundation

//-------------------------------------//
// MARK: - TabCellProtocol
//-------------------------------------//

public protocol TabCellProtocol {
    
    weak var container:TabContainer? { get set }
    
    func updateTabCell(_ item:TabItemProtocol?)
    
}

extension TabCellProtocol {
    
    public func updateTabCell(_ item:TabItemProtocol?) { debugPrint("called updateTabCell") }
    
}
