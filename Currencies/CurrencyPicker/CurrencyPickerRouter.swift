//
//  CurrencyPickerRouter.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

protocol CurrencyPickerRouterProtocol: BaseRouterProtocol {
    func dismiss()
}

class CurrencyPickerRouter: BaseRouter<CurrencyPickerViewController>, CurrencyPickerRouterProtocol {
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
