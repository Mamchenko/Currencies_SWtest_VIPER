//
//  CurrencyPickerInteractor.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

protocol CurrencyPickerInteractorProtocol: AnyObject {
    func loadCurrencies()
}

class CurrencyPickerInteractor: CurrencyPickerInteractorProtocol {

    weak var presenter: CurrencyPickerPresenterProtocol?
    var apiManager: CurrencyApiProtocol
    
    init(apiManager: CurrencyApiProtocol = CurrencyApiManager.shared) {
        self.apiManager = apiManager
    }
    
    func loadCurrencies() {
        apiManager.loadCurrencies { [weak self] currencies in
            self?.presenter?.show(currencies: currencies)
        }
    }

}
