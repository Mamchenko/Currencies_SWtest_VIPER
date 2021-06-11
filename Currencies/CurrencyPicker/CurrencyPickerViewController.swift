//
//  CurrencyPickerViewController.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

import SnapKit
import UIKit

protocol CurrencyPickerViewProtocol: AnyObject {
    func show(currencies: Currencies)
}

class CurrencyPickerViewController: UIViewController {
    
    // MARK: - Constants
    private enum UIConstants {
        static let tableViewTopInset: CGFloat = 60
        static let titleFont = UIFont.systemFont(ofSize: 25, weight: .semibold)
        static let titleInset: CGFloat = 17
    }

    // MARK: - Private properties
    let presenter: CurrencyPickerPresenterProtocol
    private let calculator: CalculatorViewProtocol
    private let field: FieldIndex
    private var currencies: Currencies = []
    private var tableView = UITableView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.titleFont
        label.text = "Выбор валюты"
        return label
    }()
    
    // MARK: - Init
    init(presenter: CurrencyPickerPresenterProtocol, calculator: CalculatorViewProtocol, field: FieldIndex) {
        self.presenter = presenter
        self.calculator = calculator
        self.field = field
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("don't use storyboards!")
    }

    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter.viewDidLoaded()
    }

    // MARK: - Private methods
    private func initialize() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalToSuperview().inset(UIConstants.tableViewTopInset)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.leading.top.equalToSuperview().inset(UIConstants.titleInset)
        }
    }

}

extension CurrencyPickerViewController: CurrencyPickerViewProtocol {
    func show(currencies: Currencies) {
        self.currencies = currencies
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CurrencyPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currencies[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        calculator.didSelectCurrency(currency: currency, field: field)
        presenter.dismiss()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
