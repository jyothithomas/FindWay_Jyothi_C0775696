//
//  Album.swift
//  FindWay_Jyothi_C0775696
//
//  Created by user176475 on 6/11/20.
//  Copyright © 2020 user176475. All rights reserved.
//

import Foundation
import <#module#>

class Album: NSObject, MKAnnotation {

    var coordinate = CLLocationCoordinate2DMake(0, 0)
    var title: String?
    var subtitle: String?


    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String {

        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }

}
