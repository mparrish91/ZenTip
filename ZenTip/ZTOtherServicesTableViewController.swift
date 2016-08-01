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
        self.tableView = UITableView(frame: CGRectZero)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        navigationController?.navigationBar.barTintColor = UIColor.whiteColor()

        let navLabel = UILabel()
        navLabel.text = "Other Services"
        navLabel.sizeToFit()
        navLabel.font = UIFont(name: "Wawati SC", size: 16)
        self.navigationItem.titleView = navLabel
        navLabel.textAlignment = NSTextAlignment.Center

        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("goBack"))
        navigationItem.rightBarButtonItem = doneButton
        doneButton.tintColor = UIColor(netHex: 0x729351)



        self.loadTableView()

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

        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")



        cell.detailTextLabel?.textColor = UIColor(netHex: 0x729351)


        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].service
        cell.detailTextLabel?.text = sections[indexPath.section].items[indexPath.row].tipAmount
        cell.textLabel?.font = UIFont(name: "Wawati SC", size: 14)
        cell.detailTextLabel?.font = UIFont(name: "Wawati SC", size: 10)


        return cell

}


    override func viewDidLoad() {
        super.viewDidLoad()




    }



    func loadTableView() {
        if var otherServicesTableView = tableView {
            otherServicesTableView = UITableView(frame: self.view.frame)
            otherServicesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
            otherServicesTableView.backgroundColor = UIColor.whiteColor()
            otherServicesTableView.scrollEnabled = true

        }


    }


    func goBack() {

        self.dismissViewControllerAnimated(true, completion: nil)

    }



}
