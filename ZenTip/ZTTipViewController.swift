//
//  ZTTipViewController.swift
//  ZenTip
//
//  Created by parry on 7/31/16.
//  Copyright © 2016 MCP. All rights reserved.
//

import UIKit

final class ZTTipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    private var backgroundImageView: UIImageView
    private var welcomeLabel: UILabel
    private var otherServicesButton: UIButton
    private var amountTextField: UITextField
    private var percentLabel: UILabel


    private var splitTextField: UITextField
    private var splitLabel: UILabel
    private var totalLabel: UILabel

    private var descriptionTableView: UITableView

    private var descriptions = ["Amazing", "Good", "Bad"]






    //MARK: NSObject

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }

    init?(_ coder: NSCoder? = nil) {
        self.backgroundImageView = UIImageView()
        self.welcomeLabel = UILabel()
        self.otherServicesButton = UIButton()
        self.amountTextField = UITextField()
        self.percentLabel = UILabel()
        self.splitTextField = UITextField()
        self.splitLabel = UILabel()
        self.totalLabel = UILabel()
        self.descriptionTableView = UITableView()

        if let coder = coder {
            super.init(coder: coder)
        }
        else {
            super.init(nibName: nil, bundle:nil)
        }


        
    }

    // MARK: UIViewController


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(netHex: 0xCEDEF1)

        welcomeLabel.text = "How was your service"
        welcomeLabel.font = UIFont(name: "Wawati SC", size: 36)
        welcomeLabel.textColor = UIColor.whiteColor()

        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .ScaleAspectFit

        amountTextField.font = UIFont(name: "Avenir-Book", size: 20)
        amountTextField.textColor = UIColor.whiteColor()
        amountTextField.attributedPlaceholder = NSAttributedString(string:"Type here to enter your city..", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName :UIFont(name: "Avenir-Book", size: 20)!])
        amountTextField.textAlignment = .Center
        amountTextField.delegate = self

        otherServicesButton.setTitle("tipping for other services?", forState: .Normal)
        otherServicesButton.titleLabel?.font = UIFont(name: "Wawati SC", size: 10)
        otherServicesButton.titleLabel?.textColor = UIColor.whiteColor()

        otherServicesButton.addTarget(self, action: #selector(onOtherServicesButtonPressed), forControlEvents: .TouchUpInside)

        descriptionTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }


    override func loadView() {
        self.view = UIView()
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(otherServicesButton)
        self.view.addSubview(amountTextField)
        self.view.addSubview(percentLabel)
        self.view.addSubview(splitTextField)
        self.view.addSubview(splitLabel)
        self.view.addSubview(totalLabel)
        self.view.addSubview(descriptionTableView)

    }


    //MARK: UITableView

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count
    }


     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.textColor = UIColor.whiteColor()

        cell.textLabel?.text = descriptions[indexPath.row]


        return cell
        
    }




    func onOtherServicesButtonPressed() {

        if let otherServicesVC = ZTOtherServicesTableViewController() {
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(otherServicesVC, animated: true, completion: nil)
            })
        }


    }



}

