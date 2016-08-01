//
//  ZTOtherServicesObject.swift
//  ZenTip
//
//  Created by parry on 7/31/16.
//  Copyright © 2016 MCP. All rights reserved.
//

import Foundation

struct ZTOtherServicesObject {
    var service : String
    var tipAmount : String

    init(service: String, tipAmount: String) {
        self.service = service
        self.tipAmount = tipAmount
    }
}
