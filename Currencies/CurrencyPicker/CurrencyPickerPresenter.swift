//
//  CurrencyPickerPresenter.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

protocol CurrencyPickerPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func show(currencies: Currencies)
    func dismiss()
}

class CurrencyPickerPresenter: CurrencyPickerPresenterProtocol {

    weak var view: CurrencyPickerViewProtocol?
    let interactor: CurrencyPickerInteractorProtocol
    let router: CurrencyPickerRouterProtocol

    init(interactor: CurrencyPickerInteractorProtocol, router: CurrencyPickerRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoaded() {
        interactor.loadCurrencies()
    }
    
    func show(currencies: Currencies) {
        view?.show(currencies: currencies)
    }
    
    func dismiss() {
        router.dismiss()
    }

}
