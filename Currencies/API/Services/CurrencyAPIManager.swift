//
//  CurrencyAPIManager.swift
//  Currencies
//
//  Created by Anatoliy Mamchenko on 09.06.2021.
//

import Foundation
import SwiftyXMLParser

protocol CurrencyApiProtocol {
    func loadCurrencies(completion: @escaping ((Currencies) -> Void))
}

class CurrencyApiManager: CurrencyApiProtocol {
    
    static let shared = CurrencyApiManager()
    
    private init() {}
    
    func loadCurrencies(completion: @escaping ((Currencies) -> Void)) {
        let url = URL(string: "https://www.cbr.ru/scripts/XML_daily.asp")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { completion([]); return }
            let xml = XML.parse(data)
            guard let count = xml["ValCurs", "Valute"].all?.count else { completion([]); return }
            var currencies = Currencies()
            for i in 0..<count {
                if let name = xml["ValCurs", "Valute", i, "Name"].text,
                   let code = xml["ValCurs", "Valute", i, "CharCode"].text,
                   let amount = xml["ValCurs", "Valute", i, "Value"].text {
                    let currency = Currency(code: code, name: name, amount: amount)
                    currencies.append(currency)
                }
            }
            completion(currencies)
        }
        task.resume()
    }
    
}
