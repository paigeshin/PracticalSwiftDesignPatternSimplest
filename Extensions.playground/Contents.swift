import UIKit
import Foundation

// Extension + Double Currency
extension Double {

    func toCurrency() -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        return currencyFormatter.string(from: NSNumber(value: self))
        
    }

}

if let currency = 23.09.toCurrency() {
    print(currency)
}
