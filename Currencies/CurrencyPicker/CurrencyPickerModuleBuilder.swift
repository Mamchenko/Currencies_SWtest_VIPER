//
//  CurrencyPickerModuleBuilder.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

class CurrencyPickerModuleBuilder {

    static func build(calculator: CalculatorViewProtocol, field: FieldIndex) -> CurrencyPickerViewController {
        let interactor = CurrencyPickerInteractor()
        let router = CurrencyPickerRouter()
        let presenter = CurrencyPickerPresenter(interactor: interactor, router: router)
        let controller = CurrencyPickerViewController(presenter: presenter, calculator: calculator, field: field)
        presenter.view = controller
        router.viewController = controller
        interactor.presenter = presenter
        return controller
    }
}
