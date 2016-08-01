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
    private var splitPromptLabel: UILabel

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
        self.splitPromptLabel = UILabel()
        self.totalLabel = UILabel()
        self.descriptionTableView = UITableView(frame: CGRectZero)

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

        welcomeLabel.text = "How was your service?"
        welcomeLabel.numberOfLines = 2
        welcomeLabel.font = UIFont(name: "Wawati SC", size: 40)
        welcomeLabel.textColor = UIColor.whiteColor()
        welcomeLabel.textAlignment = .Center

        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .ScaleToFill

//        amountTextField.font = UIFont(name: "Avenir-Book", size: 20)
//        amountTextField.textColor = UIColor.whiteColor()
//        amountTextField.attributedPlaceholder = NSAttributedString(string:"Type here to enter your city..", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName :UIFont(name: "Avenir-Book", size: 20)!])
//        amountTextField.textAlignment = .Center
//        amountTextField.delegate = self

        descriptionTableView.backgroundColor = UIColor.clearColor()
        descriptionTableView.separatorColor = UIColor.clearColor()
        descriptionTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        descriptionTableView.delegate = self
        descriptionTableView.dataSource = self



        otherServicesButton.setTitle("tipping for other services?", forState: .Normal)
        otherServicesButton.titleLabel?.font = UIFont(name: "Wawati SC", size: 10)
        otherServicesButton.titleLabel?.textColor = UIColor.whiteColor()
        otherServicesButton.addTarget(self, action: #selector(onOtherServicesButtonPressed), forControlEvents: .TouchUpInside)


        setConstraints()


    }



    override func loadView() {
        self.view = UIView()
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(otherServicesButton)
//        self.view.addSubview(amountTextField)
//        self.view.addSubview(percentLabel)
//        self.view.addSubview(splitTextField)
//        self.view.addSubview(splitLabel)
//        self.view.addSubview(totalLabel)
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
        cell.textLabel?.font = UIFont(name: "Wawati SC", size: 30)
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.frame = UIEdgeInsetsInsetRect(cell.contentView.frame, UIEdgeInsetsMake(100, 100, 100, 100))




        cell.textLabel?.text = descriptions[indexPath.row]


        return cell
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var tipPercentages = [0.10,0.15,0.20]
        var tipPercentage = Double()

        if indexPath.item == 0 {
            tipPercentage = tipPercentages[2]
        }else if indexPath.item == 1 {
            tipPercentage = tipPercentages[1]
        }else {
            tipPercentage = tipPercentages[0]

        }

        guard let text = amountTextField.text, billAmount = Double(text)  else{
            return
        }

        let tip = billAmount * tipPercentage
        let total = billAmount + tip

        percentLabel.text = "Calculated at " + String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)


    }




    func onOtherServicesButtonPressed() {


        if let otherServicesVC = ZTOtherServicesTableViewController() {
            var nav = UINavigationController()
            nav.viewControllers = [otherServicesVC]


            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(nav, animated: true, completion: nil)
            })
        }


    }

    func setViewForTip() {
        welcomeLabel.hidden = true
        descriptionTableView.hidden = true

        amountTextField.hidden = false
        splitLabel.hidden = false
        percentLabel.hidden = false
        totalLabel.hidden = false

        splitTextField.hidden = false
        splitPromptLabel.hidden = false


    }

    func resetView() {

    }


    //MARK: AutoLayout

    // FIXME: Still getting some broken constraints - look into autoresizng
    func setConstraints() {

        let margins = view.layoutMarginsGuide

        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 0).active = true
        backgroundImageView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 0).active = true
        backgroundImageView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        backgroundImageView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true

        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 25).active = true
        welcomeLabel.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 50).active = true
        welcomeLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true


        descriptionTableView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTableView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: 0).active = true
        descriptionTableView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 50).active = true
        descriptionTableView.widthAnchor.constraintEqualToAnchor(nil, constant: 150).active = true
        descriptionTableView.heightAnchor.constraintEqualToAnchor(nil, constant: 150).active = true


        otherServicesButton.translatesAutoresizingMaskIntoConstraints = false
        otherServicesButton.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor, constant: 5).active = true
        otherServicesButton.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor, constant: 5).active = true


        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountTextField.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: 0).active = true
        amountTextField.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 50).active = true
        amountTextField.widthAnchor.constraintEqualToAnchor(nil, constant: 150).active = true
        amountTextField.heightAnchor.constraintEqualToAnchor(nil, constant: 150).active = true

        splitLabel.translatesAutoresizingMaskIntoConstraints = false
        splitLabel.bottomAnchor.constraintEqualToAnchor(amountTextField.topAnchor, constant: 30).active = true
        splitLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor, constant: 10).active = true

        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.bottomAnchor.constraintEqualToAnchor(amountTextField.topAnchor, constant: 30).active = true
        percentLabel.trailingAnchor.constraintEqualToAnchor(margins.leadingAnchor, constant: 10).active = true

        splitPromptLabel.translatesAutoresizingMaskIntoConstraints = false
        splitPromptLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 0).active = true
        splitPromptLabel.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor, constant: 80).active = true

        splitTextField.translatesAutoresizingMaskIntoConstraints = false
        splitTextField.topAnchor.constraintEqualToAnchor(splitPromptLabel.bottomAnchor, constant: 25).active = true
        splitTextField.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 0).active = true
        splitTextField.widthAnchor.constraintEqualToAnchor(nil, constant: 150).active = true
        splitTextField.heightAnchor.constraintEqualToAnchor(nil, constant: 150).active = true






    }




}

