//
//  CATableViewController.swift
//  NextUI
//
//  Created by Andre Guggenberger on 21/05/16.
//  Copyright © 2016 Andre Guggenberger. All rights reserved.
//

import Foundation
import UIKit

class CATableViewController : UITableViewController {
    private var fixedHeight:CGFloat = 0.0
    private var numberOfRows = 0
    private var tableViewCell : AnyClass!
    private var styles : [Styles] = []
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return fixedHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell!
        var cell1 = cell as! CATableViewCell
        cell1.renderView(loadRowData(indexPath))
        return cell
    }
    
    func loadRowData(indexPath: NSIndexPath) -> Any? {
        return nil
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    

    
    func setTableView(rowHeight: CGFloat, tableViewCell: AnyClass, numberOfRows: Int, styles: [Styles]) {
        self.fixedHeight = rowHeight
        self.tableViewCell = tableViewCell
        self.styles = styles
        self.numberOfRows = numberOfRows
        
        self.tableView.registerClass(tableViewCell, forCellReuseIdentifier: "Cell")
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        applyLayout(cell, styles: styles)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
}

protocol CATableViewCell {
    func renderView(anyObject: Any?)
}