//
//  Resource+Local.swift
//  MeepAlbert
//
//  Created by Albert on 31/08/2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import RealmSwift

extension Resource {
    static var all: Results<Resource> {
        return try! Realm().objects(self)
    }
}

