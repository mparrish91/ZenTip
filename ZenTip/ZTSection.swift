//
//  ZTSection.swift
//  ZenTip
//
//  Created by parry on 7/31/16.
//  Copyright © 2016 MCP. All rights reserved.
//

import Foundation

struct ZTSection {
    var heading : String
    var items : [ZTOtherServicesObject]

    init(title: String, objects: [ZTOtherServicesObject]) {
        heading = title
        items = objects 
    }
}