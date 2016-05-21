//
//  AutoLayoutViewController.swift
//  NextUI
//
//  Created by Andre Guggenberger on 21/05/16.
//  Copyright © 2016 Andre Guggenberger. All rights reserved.
//

import Foundation
import UIKit

class AutoLayoutViewController : UIViewController {
    
    enum AutoLayoutStyles : String {
        case Container = "Container"
        case Title = "Title"
        case SubTitle = "SubTitle"
        case Description = "Description"
        case SubDescription = "SubDescription"
    }
    
    var styles : Styles = [
        AutoLayoutStyles.Container.rawValue: [
            .BackgroundColor:UIColor.whiteColor(),
            .ALConstraint: [
                "H:|-0-[container]-0-|",
                "V:|-0-[container]-0-|",
                "H:|-5-[title(0@250)]-5-[subtitle]-5-|",
                "V:|-100-[title]-5-[description]-[subdescription]->=5-|",
                "V:|-100-[subtitle]->=5-|",
                "H:|-5-[description]-5-|",
                "H:|-5-[subdescription]-5-|",
            ]
        ],
        AutoLayoutStyles.Title.rawValue: [
            .TextColor:UIColor.blueColor(),
        ],
        AutoLayoutStyles.SubTitle.rawValue: [
            .TextColor:UIColor.redColor(),
        ],
        AutoLayoutStyles.Description.rawValue: [
            .TextColor:UIColor.blackColor(),
            .Multiline: true
        ],
        AutoLayoutStyles.SubDescription.rawValue: [
            .TextColor:UIColor.greenColor(),
        ],
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAL(
            UIView(style: AutoLayoutStyles.Container.rawValue, children: [
                UILabel(style: AutoLayoutStyles.Title.rawValue, title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"),
                UILabel(style: AutoLayoutStyles.SubTitle.rawValue, title: "Sub Title"),
                UILabel(styles: [AutoLayoutStyles.Description.rawValue], title: "Description Description Description Description Description Description Description Description Description Description Description Description Description"),
                UILabel(styles: [AutoLayoutStyles.SubDescription.rawValue], title: "Description2 Description2 Description2 Description2 Description2 Description2 Description Description Description Description Description Description Description")
                ])
        )
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        applyStylesAndConstraints([styles, baseStyles])
    }
}