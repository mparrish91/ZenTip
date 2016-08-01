//
//  ZTOtherServicesData.swift
//  ZenTip
//
//  Created by parry on 7/31/16.
//  Copyright © 2016 MCP. All rights reserved.
//

import Foundation

class ZTOtherServicesData {

    func getSectionsFromData() -> [Section] {


        var sectionsArray = [Section]()
        let restaurants = Section(title: "Restaurants/Bars", objects:
            [ZTOtherServicesObject(service: "Waiter/ waitress", tipAmount: "small cut" ),
                ZTOtherServicesObject(service: "Wine steward", tipAmount: "15% of bottle cost" ),ZTOtherServicesObject(service: "Bartender", tipAmount: "15%" + "" + "20%" ),ZTOtherServicesObject(service: "Coatroom attendant", tipAmount: "15%" + "" + "20%" ),ZTOtherServicesObject(service: "Parking valet", tipAmount: "15%" + "" + "20%" ),ZTOtherServicesObject(service: "Washroom attendant", tipAmount: "15%" + "" + "20%" ) ])


        return sectionsArray    

    }





}