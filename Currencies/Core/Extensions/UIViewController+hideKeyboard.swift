//
//  UIViewController+hideKeyboard.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 10.06.2021.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboardView() {
        view.endEditing(true)
    }
}
