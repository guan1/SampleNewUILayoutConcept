//
//  TableViewController.swift
//  NextUI
//
//  Created by Andre Guggenberger on 21/05/16.
//  Copyright © 2016 Andre Guggenberger. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
    
    enum RealEstateDetailStyles : String {
        case Container = "Container"
        case ScrollView = "ScrollView"
        case Title = "Title"
        case Description = "Description"
        case Separator = "Separator"
        case Image = "Image"
    }
    
       
    var styles : Styles = [
        RealEstateDetailStyles.Container.rawValue: [
            .BackgroundColor:UIColor.redColor(),
            .FlexDirection: Direction.Row,
            .FlexChildAlignment: ChildAlignment.Center,
        ],
        RealEstateDetailStyles.ScrollView.rawValue: [
            .BackgroundColor:UIColor.greenColor(),
            .FlexDirection: Direction.Column,
            .FlexChildAlignment: ChildAlignment.Stretch,
            .Flex: 1
        ],
        RealEstateDetailStyles.Title.rawValue: [
            .TextColor:UIColor.blueColor(),
            .Flex: 0,
            .Multiline: true,
        ],
        RealEstateDetailStyles.Description.rawValue: [
            .Flex: 0,
            .Height: 50
            
        ],
        RealEstateDetailStyles.Image.rawValue: [
            .Flex: 0,
            .Height: 100
            
        ],
        RealEstateDetailStyles.Separator.rawValue: [
            .BackgroundColor:UIColor.yellowColor(),
            .Height:1,
        ],
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        set(
            UIView(style: RealEstateDetailStyles.Container.rawValue, children: [
                UIScrollView(style: RealEstateDetailStyles.ScrollView.rawValue, children: [
                    UIImageView(style: RealEstateDetailStyles.Image.rawValue, source: "https://upload.wikimedia.org/wikipedia/en/a/aa/Bart_Simpson_200px.png"),
                    UILabel(style: RealEstateDetailStyles.Title.rawValue, title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                    UIView(style: RealEstateDetailStyles.Separator.rawValue, height: 1),
                    UILabel(styles: [RealEstateDetailStyles.Description.rawValue, Base.DescriptionBase.rawValue], title: "Description Description Description Description Description Description Description Description Description Description Description Description Description")
                    ])
                ]))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        applyLayout([styles, baseStyles])
    }
}