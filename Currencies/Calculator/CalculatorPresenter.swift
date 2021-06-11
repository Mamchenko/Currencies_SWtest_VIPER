//
//  CalculatorPresenter.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

protocol CalculatorPresenterProtocol: AnyObject {
    func presentCurrencyPicker(for field: FieldIndex)
    func set(currency: Currency, field: FieldIndex)
    func setValue(value: Double, field: FieldIndex)
    func setValue(for field: FieldIndex, value: Double)
}

class CalculatorPresenter: CalculatorPresenterProtocol {

    weak var view: CalculatorViewProtocol?
    let interactor: CalculatorInteractorProtocol
    let router: CalculatorRouterProtocol

    init(interactor: CalculatorInteractorProtocol, router: CalculatorRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func presentCurrencyPicker(for field: FieldIndex) {
        router.openCurrencyPicker(for: field)
    }
    
    func set(currency: Currency, field: FieldIndex) {
        interactor.set(currency: currency, field: field)
    }
    
    func setValue(value: Double, field: FieldIndex) {
        interactor.setValue(value: value, field: field)
    }
    
    func setValue(for field: FieldIndex, value: Double) {
        view?.setValue(for: field, value: value)
    }

}
