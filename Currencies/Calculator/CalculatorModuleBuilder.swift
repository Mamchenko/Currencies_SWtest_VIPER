//
//  CalculatorModuleBuilder.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

class CalculatorModuleBuilder {

    static func build() -> CalculatorViewController {
        let interactor = CalculatorInteractor()
        let router = CalculatorRouter()
        let presenter = CalculatorPresenter(interactor: interactor, router: router)
        let controller = CalculatorViewController(presenter: presenter)
        presenter.view = controller
        router.viewController = controller
        interactor.presenter = presenter
        return controller
    }

}
