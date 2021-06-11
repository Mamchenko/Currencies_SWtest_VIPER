//
//  CalculatorInteractor.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

protocol CalculatorInteractorProtocol: AnyObject {
    func set(currency: Currency, field: FieldIndex)
    func setValue(value: Double, field: FieldIndex)
}

class CalculatorInteractor: CalculatorInteractorProtocol {

    weak var presenter: CalculatorPresenterProtocol?
    var apiManager: CurrencyApiProtocol
    var firstCurrency: Currency
    var secondCurrency: Currency
    
    init(apiManager: CurrencyApiProtocol = CurrencyApiManager.shared) {
        firstCurrency = Currency(code: "USD", name: "Американский доллар", amount: "1")
        secondCurrency = Currency(code: "RUB", name: "Российский рубль", amount: "75")
        self.apiManager = apiManager
    }
    
    func set(currency: Currency, field: FieldIndex) {
        switch field {
        case .first:
            firstCurrency = currency
        case .second:
            secondCurrency = currency
        }
    }
    
    func setValue(value: Double, field: FieldIndex) {
        var newValue: Double {
            switch field {
            case .first:
                return value * firstCurrency.amount.doubleValue() / secondCurrency.amount.doubleValue()
            case .second:
                return value * secondCurrency.amount.doubleValue() / firstCurrency.amount.doubleValue()
            }
        }
        presenter?.setValue(for: field.reversed(), value: newValue)
    }

}
