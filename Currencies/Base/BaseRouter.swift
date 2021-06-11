//
//  BaseRouter.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 10.06.2021.
//

import UIKit

protocol BaseRouterProtocol {
}

class BaseRouter<T>: BaseRouterProtocol where T: UIViewController {
    
    // MARK: Properties
    weak var viewController: T?
    var navigationController: UINavigationController? {
        viewController?.navigationController
    }

    // MARK: Init
    init(with viewController: T? = nil) {
        self.viewController = viewController
    }

}
