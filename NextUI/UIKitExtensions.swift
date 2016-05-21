//
//  UIKitExtensions.swift
//  NextUI
//
//  Created by Andre Guggenberger on 21/05/16.
//  Copyright © 2016 Andre Guggenberger. All rights reserved.
//

import Foundation
import UIKit


enum StyleTypes {
    case Height
    case Size
    case BackgroundColor
    case TextColor
    case FlexDirection
    case FlexChildAlignment
    case Flex
    case ALConstraint
    case NumberOfLines
    case Multiline
    
}

typealias Style = Dictionary<StyleTypes, Any>
typealias Styles = Dictionary<String, Style>

class StylesCreator {
    class func create(styles: Styles) -> StylesCreator {
        return StylesCreator()
    }
}

extension UIViewController {
    func createNode(v: UIView, styles: [Styles]) -> Node? {
        var children : [Node] = []
        
        for var vv in v.getSubviews() {
            if vv.style != nil {
                print(vv.style)
            }
            var nn = createNode(vv, styles: styles)
            if let nn = nn {
                children.append(nn)
            }
        }
        
        var s = v.style
        if s == nil {
            return nil
        }
        var style : Style = Style()
       
        var mergedStyles = Styles()
        
        for var stylesStyle in styles {
            for key in stylesStyle.keys {
                mergedStyles[key] = stylesStyle[key]
            }
        }
        
        
        for var ss in s {
            //multiple styles per UIView element are possible. Order?!?
            var oneStyle = mergedStyles[ss] as! Style!
            
            
            for key in oneStyle.keys {
                style[key] = oneStyle[key]
            }
            //var style : Style = styles[s.first!]!
        }
        
        let bcolor = style[StyleTypes.BackgroundColor] as? UIColor
        if let bcolor = bcolor {
            v.backgroundColor = bcolor
        } else {
            v.backgroundColor = UIColor.clearColor()
        }
        
        var multiline = false
        if v.isKindOfClass(UILabel.self) {
            let l = v as! UILabel
            l.textColor = style[StyleTypes.TextColor] as! UIColor
            
            if let numberOfLines = style[StyleTypes.NumberOfLines] {
                l.numberOfLines = numberOfLines as! Int
            }

            if let multiline = style[StyleTypes.Multiline] as? Bool {
                l.numberOfLines = multiline == true ? 0 : 1
            }
            
            if l.numberOfLines == 0 {
                multiline = true
            }
        }
        
        
        var size : CGSize
        var measure : (CGFloat -> CGSize)?
        
        if style[StyleTypes.Size] != nil {
            size = style[StyleTypes.Size] as! CGSize
        } else {
           size = CGSize(width: Node.Undefined, height: Node.Undefined)
           /* v.sizeToFit()
            size = v.frame.size
            measure = {
                (f: CGFloat) -> CGSize in
                v.sizeToFit()
                return CGSizeMake(f, v.frame.size.height)
            }*/
        }
        var height = style[StyleTypes.Height]
        
        if multiline && height == nil {
            height = Int.max
            
        }
        
        if height != nil {
            size = CGSize(width: Node.Undefined, height: CGFloat(height as! Int))
            measure = nil
            let h = height as! Int
            if h == Int.max {
                size = CGSize(width: Node.Undefined, height:  Node.Undefined)
                measure = {
                    (f: CGFloat) -> CGSize in
                    
                    let frame = CGRectMake(0, 0, f, CGFloat.max)
                    v.frame = frame
                    v.sizeToFit()
                    
                    return CGSizeMake(f, v.frame.size.height)
                }
            } else {
               
            }
        }
        else {
            measure = nil
        }
        
        var childAllignment : ChildAlignment
        if style[StyleTypes.FlexChildAlignment] != nil {
            childAllignment = style[StyleTypes.FlexChildAlignment] as! ChildAlignment
        } else {
            childAllignment = ChildAlignment.Stretch
        }
        
        var direction : Direction
        if style[StyleTypes.FlexDirection] != nil {
            direction = style[StyleTypes.FlexDirection] as! Direction
        } else {
            direction = Direction.Column
        }
        
        var flex:CGFloat = 0.0
        
        if style[StyleTypes.Flex] != nil {
            flex = CGFloat(style[StyleTypes.Flex] as! Int)
        }
        
        
        
        
        let node = Node(size: size,
                        childAlignment: childAllignment,
                        direction: direction,
                        flex: flex,
                        children: children,
                        measure: measure)
        
        return node
        
    }
    
    
    func add(childView: UIView, styles: [Styles]) {
        view.addSubview(childView)
        
        let node = createNode(childView, styles:styles)
        
        let layout = node!.layout()
        print(layout)
        layout.apply(childView)
    }
    
}
extension UIScrollView {
    
}

extension UIImage {
    var style: [String]! {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey1) as? [String]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey1, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    convenience init(style style: String, source: String)
    {
        let url = NSURL(string: source)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        self.init(data: data!)!
        self.style = [style]
    }
}

private var xoAssociationKey: UInt8 = 0
private var xoAssociationKey1: UInt8 = 0

extension UIView {
    var style: [String]! {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? [String]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    convenience init(style style: String, height: CGFloat = 0)
    {
        self.init(frame: CGRectMake(0, 0, 1, height))
        self.backgroundColor = UIColor.brownColor()
        self.style = [style]
    }
    
    convenience init(style style: String, height: CGFloat = 0, children: [UIView])
    {
        self.init()
        for var v in children {
            addSubview(v)
        }
        self.style = [style]
    }
    
    //view.subviews also returns layout guides.
    func getSubviews() -> Array<UIView>{
        var subviews = Array<UIView>()
        for s in self.subviews {
            if s.conformsToProtocol(UILayoutSupport) == false {
                subviews.append(s)
            }
        }
        
        return subviews
    }
}

extension UILabel {
    convenience init(style style: String, title: String)
    {
        self.init()
        self.text = title
        self.style = [style]
    }
    convenience init(styles styles: [String], title: String)
    {
        self.init()
        self.text = title
        self.style = styles
    }
  
}
