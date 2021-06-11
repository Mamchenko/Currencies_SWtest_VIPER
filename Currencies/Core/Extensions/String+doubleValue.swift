//
//  String+doubleValue.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 10.06.2021.
//

import Foundation

extension String {
    func doubleValue() -> Double {
        return (self as NSString).doubleValue
    }
}
