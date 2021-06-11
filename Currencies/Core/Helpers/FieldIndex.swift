//
//  FieldIndex.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 10.06.2021.
//

enum FieldIndex: Int {
    case first = 1
    case second = 2
}

extension FieldIndex {
    func reversed() -> FieldIndex {
        switch self {
        case .first: return .second
        case .second: return .first
        }
    }
}
