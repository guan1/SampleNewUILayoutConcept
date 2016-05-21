//
//  ViewController.swift
//  NextUI
//
//  Created by Andre Guggenberger on 20/05/16.
//  Copyright (c) 2016 Andre Guggenberger. All rights reserved.
//


import UIKit

class ViewController: CATableViewController {
    
    enum RealEstateStyles : String {
        case Container = "Container"
        case Title = "Title"
        case Description = "Description"
        case Image = "Image"
    }
        
    var styles : Styles = [
        RealEstateStyles.Container.rawValue: [
            .BackgroundColor:UIColor.redColor(),
            .FlexDirection: Direction.Column,
            .FlexChildAlignment: ChildAlignment.Stretch,
            .Flex: 1
        ],
        RealEstateStyles.Title.rawValue: [
            .TextColor:UIColor.blueColor(),
            .Flex: 1,
            .Multiline: false,
        ],
        RealEstateStyles.Description.rawValue: [
            .Flex: 1,
            .Height: 50,
            .TextColor: UIColor.whiteColor()
            
        ],
        RealEstateStyles.Image.rawValue: [
            .Flex: 1,
            .Height: 200
            
        ],
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setTableView(200, tableViewCell: RealEstateTableViewCell.self, numberOfRows: 1000, styles: [styles])
    }
    
    override func loadRowData(indexPath: NSIndexPath) -> Any? {
        return indexPath.row
    }
    
   
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    class RealEstateTableViewCell : UITableViewCell, CATableViewCell {
        var realEstateImageView : UIImageView!
        var realEstateTitleLabel: UILabel?
        var realEstateDescriptionLabel: UILabel?
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            //TODO: something better for binding? (see Mapper in Bauradar?)
            realEstateTitleLabel = UILabel()
            realEstateDescriptionLabel = UILabel()
            
            
            add(self.contentView,
                childView: UIView(style: RealEstateStyles.Container.rawValue, children: [
                    UIImageView(style: RealEstateStyles.Image.rawValue, source: "https://upload.wikimedia.org/wikipedia/en/a/aa/Bart_Simpson_200px.png"),
                    UILabel(style: RealEstateStyles.Title.rawValue, title: "Text ", ref: &realEstateTitleLabel!),
                    UILabel(style: RealEstateStyles.Description.rawValue, title: "Description ", ref: &realEstateDescriptionLabel!)
                    ]))
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func renderView(anyObject: Any?) {
            let realEstate = anyObject!
            realEstateTitleLabel!.text! = "Text \(realEstate)"
            realEstateDescriptionLabel!.text! = "Description \(realEstate)"
        }
        
        
        
    }
}
