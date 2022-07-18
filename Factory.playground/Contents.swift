import UIKit

enum FruitType {
    case apple
    case orange
}
    
protocol Fruit {
    var name: String { get }
}

struct Apple: Fruit {
    var name: String = "Apple"
}

struct Orange: Fruit {
    var name: String = "Orange"
}

class FruitFactory {
    
    static let shared = FruitFactory()
    
    private init() {}
    
    func makeFruit(ofType type: FruitType) -> Fruit {
        switch type {
        case .apple:
            return Apple()
        case .orange:
            return Orange()
        }
    }
    
}

let apple = FruitFactory.shared.makeFruit(ofType: .apple)
