import UIKit

struct Product {
    var name: String
}

protocol ProductDeliveryDelegate {
    func send(product: Product)
}

struct OnlineShop {
    
    private(set) var shopName: String
    private(set) var products = [Product]()
    private var productDeliveryDelegate: ProductDeliveryDelegate?
    
    init(shopName: String) {
        self.shopName = shopName
        let delivery = Delivery()
        productDeliveryDelegate = delivery
    }
    
    mutating func add(product: Product) {
        self.products.append(product)
    }
    
    func sendAllProducts() {
        for product in products {
            productDeliveryDelegate?.send(product: product)
        }
    }
    

    
}

class Delivery: ProductDeliveryDelegate {

    func send(product: Product) {
        print("\(product.name) sent!")
    }

}

var onlineShop = OnlineShop(shopName: "Amazon")
onlineShop.add(product: Product(name: "MacBook Pro"))
onlineShop.add(product: Product(name: "Apple Watch"))
onlineShop.add(product: Product(name: "iMac"))
onlineShop.sendAllProducts()
