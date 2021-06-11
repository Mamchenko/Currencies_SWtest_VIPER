//
//  CalculatorViewController.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

import SnapKit
import UIKit

protocol CalculatorViewProtocol: AnyObject {
    func didSelectCurrency(currency: Currency, field: FieldIndex)
    func setValue(for field: FieldIndex, value: Double)
}

class CalculatorViewController: UIViewController {

    let presenter: CalculatorPresenterProtocol
    
    private enum UIConstants {
        static let fieldLeadingInset: CGFloat = 10
        static let fieldTrailingInset: CGFloat = 100
        static let firstFieldTopInset: CGFloat = 150
        static let fieldHeight: CGFloat = 30
        static let fieldsOffset: CGFloat = 10
        static let fieldCornerRadius: CGFloat = 5
        static let fieldWidth: CGFloat = 1
        static let fieldBorderColor: CGColor = UIColor.gray.cgColor
        static let fieldToButtonOffset: CGFloat = 10
        static let buttonRightInset: CGFloat = 20
        static let textFieldLeftInset: CGFloat = 15
    }
    
    private var firstField: UITextField = {
        let textField = UITextField()
        textField.tag = FieldIndex.first.rawValue
        textField.layer.cornerRadius = UIConstants.fieldCornerRadius
        textField.layer.borderWidth = UIConstants.fieldWidth
        textField.layer.borderColor = UIConstants.fieldBorderColor
        textField.text = "0"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: UIConstants.textFieldLeftInset, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private var secondField: UITextField = {
        let textField = UITextField()
        textField.tag = FieldIndex.second.rawValue
        textField.layer.cornerRadius = UIConstants.fieldCornerRadius
        textField.layer.borderWidth = UIConstants.fieldWidth
        textField.layer.borderColor = UIConstants.fieldBorderColor
        textField.text = "0"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: UIConstants.textFieldLeftInset, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private var firstCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RUB", for: .normal)
        return button
    }()
    
    private var secondCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("USD", for: .normal)
        return button
    }()
    
    // MARK: - Init
    init(presenter: CalculatorPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("don't use storyboards!")
    }

    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    // MARK: - Private methods
    private func initialize() {
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        [firstField, secondField, firstCurrencyButton, secondCurrencyButton].forEach({ view.addSubview($0) })
        [firstField, secondField].forEach({
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        })
        firstCurrencyButton.addTarget(self, action: #selector(firstCurrencyTapped), for: .touchUpInside)
        secondCurrencyButton.addTarget(self, action: #selector(secondCurrencyTapped), for: .touchUpInside)
        firstField.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(UIConstants.fieldLeadingInset)
            maker.trailing.equalToSuperview().inset(UIConstants.fieldTrailingInset)
            maker.top.equalToSuperview().inset(UIConstants.firstFieldTopInset)
            maker.height.equalTo(UIConstants.fieldHeight)
        }
        secondField.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(UIConstants.fieldLeadingInset)
            maker.trailing.equalToSuperview().inset(UIConstants.fieldTrailingInset)
            maker.top.equalTo(firstField.snp.bottom).offset(UIConstants.fieldsOffset)
            maker.height.equalTo(UIConstants.fieldHeight)
        }
        firstCurrencyButton.snp.makeConstraints { maker in
            maker.centerY.equalTo(firstField)
            maker.leading.equalTo(firstField.snp.trailing).offset(UIConstants.fieldToButtonOffset)
            maker.trailing.equalToSuperview().inset(UIConstants.buttonRightInset)
        }
        secondCurrencyButton.snp.makeConstraints { maker in
            maker.centerY.equalTo(secondField)
            maker.leading.equalTo(secondField.snp.trailing).offset(UIConstants.fieldToButtonOffset)
            maker.trailing.equalToSuperview().inset(UIConstants.buttonRightInset)
        }
    }
    
    @objc private func firstCurrencyTapped() {
        presenter.presentCurrencyPicker(for: .first)
    }
    
    @objc private func secondCurrencyTapped() {
        presenter.presentCurrencyPicker(for: .second)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        var text: String {
            if textField.text?.isEmpty ?? true {
                return "0"
            } else {
                return textField.text!
            }
        }
        presenter.setValue(value: Double(text) ?? 0, field: FieldIndex.init(rawValue: textField.tag)!)
    }
}

// MARK: - CalculatorViewProtocol
extension CalculatorViewController: CalculatorViewProtocol {
    func didSelectCurrency(currency: Currency, field: FieldIndex) {
        switch field {
        case .first:
            firstCurrencyButton.setTitle(currency.code, for: .normal)
        case .second:
            secondCurrencyButton.setTitle(currency.code, for: .normal)
        }
        presenter.set(currency: currency, field: field)
    }
    
    func setValue(for field: FieldIndex, value: Double) {
        switch field {
        case .first:
            firstField.text = String(value)
        case .second:
            secondField.text = String(value)
        }
    }
}

// MARK: - UITextFieldDelegate
extension CalculatorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text: String {
            if textField.text?.isEmpty ?? true {
                return "0"
            } else {
                return textField.text!
            }
        }
        let set = NSCharacterSet(charactersIn:"0123456789.,").inverted
        let compSepByCharInSet = text.components(separatedBy: set)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return text == numberFiltered
    }
}
