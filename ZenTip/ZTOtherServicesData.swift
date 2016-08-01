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
                ZTOtherServicesObject(service: "Wine steward", tipAmount: "15% of bottle cost" ),ZTOtherServicesObject(service: "Bartender", tipAmount: "15% to 20%, $1 per drink" ),ZTOtherServicesObject(service: "Coatroom attendant", tipAmount: "$1 per coat" ),ZTOtherServicesObject(service: "Parking valet", tipAmount: "$2 to bring your car to you" ),ZTOtherServicesObject(service: "Washroom attendant", tipAmount: "50 cents to $1" ) ])

        let dailyLife = Section(title: "Daily Life", objects:
            [ZTOtherServicesObject(service: "Taxi driver", tipAmount: "15%; extra $1 or $2 for help with bags" ),
            ZTOtherServicesObject(service: "Food delivery person", tipAmount: "10% or 15-20% for difficult deliveries" ),
                ZTOtherServicesObject(service: "Grocery loader", tipAmount: "$1-3" ),ZTOtherServicesObject(service: "Barber", tipAmount: "15%" + "" + "20%" ),
                ZTOtherServicesObject(service: "Hairdresser", tipAmount: "15%" + "" + "20%" ),ZTOtherServicesObject(service: "Shampoo person", tipAmount: "15%" + "" + "20%" ),ZTOtherServicesObject(service: "Manicurist", tipAmount: "15%" + "" + "20%" ),
            ZTOtherServicesObject(service: "Spa service", tipAmount: "15%" + "" + "20%" )
            ZTOtherServicesObject(service: "Staff at coffee/food retailers with tip jars", tipAmount: "15%" + "" + "20%" )
            ZTOtherServicesObject(service: "Handyman", tipAmount: "15%" + "" + "20%" ),
                ZTOtherServicesObject(service: "Gas attendant", tipAmount: "15%" + "" + "20%" )
            ])

        let travel = Section(title: "Skypcap", objects:
            [ZTOtherServicesObject(service: "Skypcap", tipAmount: "small cut" ),
            ZTOtherServicesObject(service: "Hotel doorman", tipAmount: "small cut" ),
                ZTOtherServicesObject(service: "Hotel bellhop", tipAmount: "15% of bottle cost" ),ZTOtherServicesObject(service: "Hotel housekeper", tipAmount: "15%" + "" + "20%" ),ZTOtherServicesObject(service: "Hotel concierge", tipAmount: "15%" + "" + "20%" ),ZTOtherServicesObject(service: "Cruise", tipAmount: "15%" + "" + "20%" )])


        return sectionsArray

    }





}