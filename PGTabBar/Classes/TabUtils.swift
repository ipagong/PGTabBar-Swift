//
//  TabUtils.swift
//  Pods
//
//  Created by ipagong on 2017. 4. 19..
//
//

import Foundation

public class TabText {
    private var text:String = ""
    private var attributes:[String:Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.black]
    
    public class func title(_ title:String) -> TabText {
        let text = TabText()
        text.text = title
        return text
    }
    
    public func title(_ title:String) -> TabText {
        self.text = title
        return self
    }
    
    public func font(_ font:UIFont) -> TabText {
        self.attributes.updateValue(font, forKey: NSFontAttributeName)
        return self
    }
    
    public func font(size:CGFloat) -> TabText {
        self.attributes.updateValue(UIFont.systemFont(ofSize: size), forKey: NSFontAttributeName)
        return self
    }
    
    public func boldFont(size:CGFloat) -> TabText {
        self.attributes.updateValue(UIFont.boldSystemFont(ofSize: size), forKey: NSFontAttributeName)
        return self
    }
    
    public func color(_ color:UIColor) -> TabText {
        self.attributes.updateValue(color, forKey: NSForegroundColorAttributeName)
        return self
    }
    
    public func add(_ value:Any, attrKey:String) -> TabText {
        self.attributes.updateValue(value, forKey: attrKey)
        return self
    }
    
    public var attrText:NSAttributedString {
        return NSAttributedString(string: text, attributes: attributes)
    }
    
}

public struct TabStateElement<Element:Any> {
    var normal:Element
    var selected:Element?
    var highlighted:Element?
    var disabled:Element?
    
    public init(common:Element) {
        self.normal      = common
        self.selected    = common
        self.highlighted = common
        self.disabled    = common
    }
    
    public init(normal:Element, selected:Element, highlighted:Element, disabled:Element) {
        self.normal      = normal
        self.selected    = selected
        self.highlighted = highlighted
        self.disabled    = disabled
    }
}

extension NSInteger {
    func indexPath(_ section:NSInteger? = 0) -> IndexPath { return IndexPath(row: self, section: section!) }
}

