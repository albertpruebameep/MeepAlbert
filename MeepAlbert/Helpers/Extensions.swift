//
//  Extensions.swift
//  MeepAlbert
//
//  Created by Albert on 31/08/2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var randomColor: UIColor {
        get {
            return UIColor(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 1.0)
        }
    }
}
