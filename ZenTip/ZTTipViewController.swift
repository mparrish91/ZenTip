//
//  ZTTipViewController.swift
//  ZenTip
//
//  Created by parry on 7/31/16.
//  Copyright © 2016 MCP. All rights reserved.
//

import UIKit

public enum UITableViewScrollPosition : Int {

    case None
    case Top
    case Middle
    case Bottom
}


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
    private var backButton: UIButton


    private var descriptions = ["Amazing", "Good", "Bad"]

    private var tipPercentage = Double()

    private var total = Double()






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
        self.backButton = UIButton()


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
        welcomeLabel.font = UIFont(name: "Wawati SC", size: 36)
        welcomeLabel.textColor = UIColor.whiteColor()
        welcomeLabel.textAlignment = .Center

        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .ScaleAspectFill

        descriptionTableView.backgroundColor = UIColor.clearColor()
        descriptionTableView.separatorColor = UIColor.clearColor()
        descriptionTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        descriptionTableView.delegate = self
        descriptionTableView.dataSource = self

        otherServicesButton.setTitle("tipping for other services?", forState: .Normal)
        otherServicesButton.titleLabel?.font = UIFont(name: "Wawati SC", size: 10)
        otherServicesButton.titleLabel?.textColor = UIColor.whiteColor()
        otherServicesButton.addTarget(self, action: #selector(onOtherServicesButtonPressed), forControlEvents: .TouchUpInside)

        amountTextField.font = UIFont(name: "Wawati SC", size: 35)
        amountTextField.textColor = UIColor.whiteColor()
        amountTextField.attributedPlaceholder = NSAttributedString(string:"$ Enter an amount", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName :UIFont(name: "Wawati SC", size: 38)!])
        amountTextField.textAlignment = .Center
        amountTextField.delegate = self
        amountTextField.addTarget(self, action: #selector(onEditingChanged), forControlEvents: .EditingChanged)



        percentLabel.font = UIFont(name: "Wawati SC", size: 12)
        percentLabel.textColor = UIColor.whiteColor()
        percentLabel.textAlignment = .Center

        splitLabel.font = UIFont(name: "Wawati SC", size: 12)
        splitLabel.textColor = UIColor.whiteColor()
        splitLabel.textAlignment = .Center

        totalLabel.font = UIFont(name: "Wawati SC", size: 49)
        totalLabel.textColor = UIColor.whiteColor()
        totalLabel.textAlignment = .Center

        splitPromptLabel.text = "If splitting how many?"
        splitPromptLabel.font = UIFont(name: "Wawati SC", size: 28)
        splitPromptLabel.textColor = UIColor.whiteColor()
        splitPromptLabel.textAlignment = .Center

        splitTextField.font = UIFont(name: "Wawati SC", size: 35)
        splitTextField.textColor = UIColor.whiteColor()
        splitTextField.attributedPlaceholder = NSAttributedString(string:"--", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName :UIFont(name: "Wawati SC", size: 30)!])
        splitTextField.textAlignment = .Center
        splitTextField.delegate = self
        splitTextField.addTarget(self, action: #selector(onSplitTextFieldChanged), forControlEvents: .EditingChanged)

        let indexPath = NSIndexPath(forItem: 1, inSection: 0)
        descriptionTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: true)

        let image = UIImage(named: "backButton")
        backButton.setImage(image, forState: .Normal)
        backButton.tintColor = UIColor.whiteColor()
        backButton.addTarget(self, action: #selector(ZTTipViewController.resetView), forControlEvents: .TouchUpInside)



        UIApplication.sharedApplication().statusBarHidden = true


        resetView()

        setConstraints()


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
        self.view.addSubview(splitPromptLabel)
        self.view.addSubview(totalLabel)
        self.view.addSubview(descriptionTableView)
        self.view.addSubview(backButton)


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
        cell.selectionStyle = .None


        cell.textLabel?.text = descriptions[indexPath.row]

        //handling startup
        if cell.selected == true {
            cell.backgroundColor = UIColor.clearColor()
            cell.textLabel?.backgroundColor = UIColor.clearColor()
            cell.selectedBackgroundView = nil
            cell.textLabel?.font =  UIFont(name: "Wawati SC", size: 48)
        }


        return cell
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        //handling startup


        let theCell:UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)

        if let theCell = theCell {
            var tableViewCenter:CGPoint = tableView.contentOffset
            tableViewCenter.y += tableView.frame.size.height/2

            tableView.contentOffset = CGPointMake(0, theCell.center.y-65)
            tableView.reloadData()
        }



        var tipPercentages = [0.10,0.15,0.20]

        if indexPath.item == 0 {
            tipPercentage = tipPercentages[2]
            percentLabel.text = "Calculated at 20%"

        }else if indexPath.item == 1 {
            tipPercentage = tipPercentages[1]
            percentLabel.text = "Calculated at 15%"

        }else {
            tipPercentage = tipPercentages[0]
            percentLabel.text = "Calculated at 10%"


        }

        setViewForTip()




    }

    func onEditingChanged() {

        guard let text = amountTextField.text, billAmount = Double(text)  else{
            return
        }

        let tip = billAmount * tipPercentage
        total = billAmount + tip

        totalLabel.text = String(format: "$%.2f", total)

        splitTextField.hidden = false
        splitPromptLabel.hidden = false


    }

    func onSplitTextFieldChanged() {

        var newTotal = total / Double(splitTextField.text!)!

        totalLabel.text = String(format: "$%.2f", newTotal)
        splitLabel.text = "Split " + splitTextField.text! + "ways"

    }

    func onTap(){
        view.endEditing(true)


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
        backButton.hidden = false



    }

    func resetView() {

        welcomeLabel.hidden = false
        descriptionTableView.hidden = false

        amountTextField.hidden = true
        splitLabel.hidden = true
        percentLabel.hidden = true
        totalLabel.hidden = true

        splitTextField.hidden = true
        splitPromptLabel.hidden = true
        backButton.hidden = true


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
        amountTextField.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 0).active = true
        amountTextField.topAnchor.constraintEqualToAnchor(margins.topAnchor, constant: 25).active = true

        splitLabel.translatesAutoresizingMaskIntoConstraints = false
        splitLabel.bottomAnchor.constraintEqualToAnchor(totalLabel.topAnchor, constant: 30).active = true
        splitLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor, constant: 10).active = true

        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.bottomAnchor.constraintEqualToAnchor(totalLabel.topAnchor, constant: 50).active = true
        percentLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor, constant: 10).active = true

        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: 0).active = true
        totalLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 50).active = true


        splitPromptLabel.translatesAutoresizingMaskIntoConstraints = false
        splitPromptLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 0).active = true
        splitPromptLabel.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor, constant: -80).active = true

        splitTextField.translatesAutoresizingMaskIntoConstraints = false
        splitTextField.topAnchor.constraintEqualToAnchor(splitPromptLabel.bottomAnchor, constant: 10).active = true
        splitTextField.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 0).active = true



        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor, constant: 3).active = true
        backButton.topAnchor.constraintEqualToAnchor(margins.topAnchor, constant: 5).active = true
        backButton.widthAnchor.constraintEqualToAnchor(nil, constant: 20).active = true
        backButton.heightAnchor.constraintEqualToAnchor(nil, constant: 20).active = true




    }




}

