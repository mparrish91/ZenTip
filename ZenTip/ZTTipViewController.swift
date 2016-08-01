//
//  ZTTipViewController.swift
//  ZenTip
//
//  Created by parry on 7/31/16.
//  Copyright © 2016 MCP. All rights reserved.
//

import UIKit

final class ZTTipViewController: UIViewController {

    private var backgroundImageView: UIImageView
    private var welcomeLabel: UILabel
    private var otherServicesButton: UIButton
    private var amountTextField: UITextField
    private var percentLabel: UILabel


    private var splitTextField: UITextField
    private var splitLabel: UILabel
    private var totalLabel: UILabel

    private var descriptionTableView: UITableView






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

        titleLabel.text = "Weathermate"
        titleLabel.font = UIFont(name: "Avenir-Book", size: 36)
        titleLabel.textColor = UIColor.whiteColor()

        locationTextField.font = UIFont(name: "Avenir-Book", size: 20)
        locationTextField.textColor = UIColor.whiteColor()
        locationTextField.attributedPlaceholder = NSAttributedString(string:"Type here to enter your city..", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName :UIFont(name: "Avenir-Book", size: 20)!])
        locationTextField.textAlignment = .Center
        locationTextField.delegate = self

        submitButton.setTitle("Submit", forState: .Normal)
        submitButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
        submitButton.layer.borderWidth = 0.0
        submitButton.titleLabel?.textColor = UIColor.whiteColor()

        progressView.progressTintColor = UIColor.yellowColor()
        progressView.trackTintColor = UIColor.whiteColor()

        otherServicesButton.addTarget(self, action: #selector(onOtherServicesButtonPressed), forControlEvents: .TouchUpInside)
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
        self.view.addSubview(self.totalLabel)
        self.view.addSubview(descriptionTableView)

    }



    func onOtherServicesButtonPressed() {
        
    }



}

