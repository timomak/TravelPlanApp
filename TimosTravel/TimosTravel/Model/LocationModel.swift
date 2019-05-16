//
//  LocationModel.swift
//  TimosTravel
//
//  Created by timofey makhlay on 5/15/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import MapKit

class Location {
    var name: String
    var address: MKAnnotationView
    
    init(name: String, address: MKAnnotationView) {
        self.name = name
        self.address = address
    }
}
