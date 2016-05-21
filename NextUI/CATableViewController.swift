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
    private var numberOfRows : Int?
    private var tableViewCell : AnyClass!
    private var styles : [Styles] = []
    
    private var numberOfRowsAction : (() -> Int)!
    private var rowSelectionAction : ((NSIndexPath) -> ())!
    private var retrieveDataAction : ((indexPath: NSIndexPath) -> Any?)!
    
    func setStyles(styles: [Styles]) {
        self.styles = styles
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return fixedHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell!
        let cell1 = cell as! CATableViewCell
        
        if let retrieveDataAction = retrieveDataAction {
            cell1.renderView(retrieveDataAction(indexPath: indexPath))
        } else {
            cell1.renderView(loadRowData(indexPath))
        }
        
        return cell
    }
    
    func loadRowData(indexPath: NSIndexPath) -> Any? {
        return nil
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = numberOfRows {
            return numberOfRows
        } else if let numberOfRowsAction = numberOfRowsAction {
            return numberOfRowsAction()
        }
        
        return 0
    }
    

    
    func setTableView(rowHeight: CGFloat, tableViewCell: AnyClass, numberOfRows: Int) {
        self.fixedHeight = rowHeight
        self.tableViewCell = tableViewCell
        self.numberOfRows = numberOfRows
        
        self.tableView.registerClass(tableViewCell, forCellReuseIdentifier: "Cell")
    }
    
    func setTableView(rowHeight rowHeight: CGFloat, tableViewCell: AnyClass, numberOfRows: () -> Int, rowSelectionAction: (indexPath: NSIndexPath) -> (), retrieveData: (indexPath: NSIndexPath) -> Any?) {
        self.fixedHeight = rowHeight
        self.tableViewCell = tableViewCell
        self.numberOfRowsAction = numberOfRows
        self.rowSelectionAction = rowSelectionAction
        self.retrieveDataAction = retrieveData
        
        self.tableView.registerClass(tableViewCell, forCellReuseIdentifier: "Cell")
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let rowSelectionAction = rowSelectionAction {
            rowSelectionAction(indexPath)
        }
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