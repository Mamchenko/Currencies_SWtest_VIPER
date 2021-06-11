//
//  CalculatorRouter.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

protocol CalculatorRouterProtocol: BaseRouterProtocol {
    func openCurrencyPicker(for field: FieldIndex)
}

class CalculatorRouter: BaseRouter<CalculatorViewController>, CalculatorRouterProtocol {
    func openCurrencyPicker(for field: FieldIndex) {
        guard let viewController = viewController else { return }
        let currencyPicker = CurrencyPickerModuleBuilder.build(calculator: viewController, field: field)
        viewController.present(currencyPicker, animated: true, completion: nil)
    }
}
