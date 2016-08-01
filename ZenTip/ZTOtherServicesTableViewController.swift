//
//  ZTOtherServicesTableViewController.swift
//  ZenTip
//
//  Created by parry on 7/31/16.
//  Copyright © 2016 MCP. All rights reserved.
//

import UIKit

final class ZTOtherServicesTableViewController: UITableViewController {

    private var sections: [ZTSection] = ZTOtherServicesData().getSectionsFromData()

    //MARK: NSObject

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }

    init?(_ coder: NSCoder? = nil) {

        if let coder = coder {
            super.init(coder: coder)
        }
        else {
            super.init(nibName: nil, bundle:nil)
        }

        self.loadTableView()
        self.title = "Other Services"

    }


    //MARK: UITableView

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].heading
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.textColor = UIColor(netHex: 0x729351)
        cell.detailTextLabel?.textColor = UIColor(netHex: 0x729351)


        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].service
        cell.detailTextLabel?.text = sections[indexPath.section].items[indexPath.row].tipAmount

        return cell

    }


    func loadTableView() {
        if var otherServicesTableView = tableView {
            otherServicesTableView = UITableView(frame: CGRectZero)
            otherServicesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

            otherServicesTableView.frame = self.view.frame
            otherServicesTableView.backgroundColor = UIColor.whiteColor()
            otherServicesTableView.scrollEnabled = true

        }


    }

}
