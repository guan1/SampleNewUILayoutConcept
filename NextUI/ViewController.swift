//
//  ViewController.swift
//  NextUI
//
//  Created by Andre Guggenberger on 20/05/16.
//  Copyright (c) 2016 Andre Guggenberger. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    enum Base : String {
        case DescriptionBase = "DescriptionBase"
    }
    
    enum RealEstateStyles : String {
        case Container = "Container"
        case ScrollView = "ScrollView"
        case Title = "Title"
        case Description = "Description"
        case Separator = "Separator"
    }
    
    let baseStyles : Styles = [
        Base.DescriptionBase.rawValue: [
        .TextColor:UIColor.whiteColor(),
        ]
    ]
    
    var styles : Styles = [
        RealEstateStyles.Container.rawValue: [
            .BackgroundColor:UIColor.redColor(),
            .FlexDirection: Direction.Row,
            .FlexChildAlignment: ChildAlignment.Center,
        ],
        RealEstateStyles.ScrollView.rawValue: [
            .BackgroundColor:UIColor.greenColor(),
            .FlexDirection: Direction.Column,
            .FlexChildAlignment: ChildAlignment.Stretch,
            .Flex: 1
        ],
        RealEstateStyles.Title.rawValue: [
            .TextColor:UIColor.blueColor(),
            .Flex: 0,
            .Multiline: true,
        ],
        RealEstateStyles.Description.rawValue: [
            .Flex: 0,
            .Height: 50
            
        ],
        RealEstateStyles.Separator.rawValue: [
            .BackgroundColor:UIColor.whiteColor(),
            .Height:1,
        ],
        ]
    
     override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        set(
            UIView(style: RealEstateStyles.Container.rawValue, children: [
                UIScrollView(style: RealEstateStyles.ScrollView.rawValue, children: [
                    UILabel(style: RealEstateStyles.Title.rawValue, title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                    UIView(style: RealEstateStyles.Separator.rawValue, height: 1),
                    UILabel(styles: [RealEstateStyles.Description.rawValue, Base.DescriptionBase.rawValue], title: "Description Description Description Description Description Description Description Description Description Description Description Description Description")
                ])
            ]))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        applyLayout([styles, baseStyles])
    }
}
