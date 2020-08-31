//
//  Resource.swift
//  MeepAlbert
//
//  Created by Albert on 30/08/2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

final class Resource: Object {
    @objc dynamic var  id: String = ""
    @objc dynamic var  name: String = ""
    @objc dynamic var  lat: Double = 0.0
    @objc dynamic var  lon: Double = 0.0
    @objc dynamic var  companyZoneId: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience required init(_ json: JSON) {
        self.init()
        self.id = json["id"].stringValue
        self.name = json["name"].string ?? ""
        self.lat = json["y"].double ?? 0.0
        self.lon = json["x"].double ?? 0.0
        self.companyZoneId = json["companyZoneId"].int ?? 0
    }
    
    convenience required init(id: String, name: String, lat: Double, lon: Double, companyZoneId: Int) {
        self.init()
        self.id = id
        self.name = name
        self.lat = lat
        self.lon = lon
        self.companyZoneId = companyZoneId
    }
}
