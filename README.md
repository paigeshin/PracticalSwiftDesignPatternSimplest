# SOLID Design Pattern

# Software Design

*Note: I will be using the term “entity” to loosely refer to a class, structure or object

Design patterns are reusable solutions to common problems in software design. There are broadly three types of design patterns according to the Gang of Four’s book **Design Patterns: Elements of Reusable Object-Oriented Software:**

- **Creational - deal with entirely creation e.g. Singleton and Factory Design Pattern**
- **Structural - identify a simple way to realize relationships between entities. e.g. Adapter Design Pattern.**
- **Behavioral - Identify common communication patterns between entities e.g. Observer Design Pattern**

**Delegation** and **Extensions** are often referred to as design patterns in some circles. They are design patterns in the sense they are used as the basis for many other design patterns to work.

MVC and MVVM are often referred to as design patterns as well but it is often more correct to refer to them as architectural design patterns which is distinct from the three design pattern types defined by the Gang of Four. The evidence of this is found in the very book that made MVC famous, Pattern-Oriented Software Architecture which clearly identifies MVC as an architectural design pattern.

Software principles are a set of guidelines that make our code easier to maintain, test, understand and manage as it grows in size. Example of software principles include the DRY (Do Not Repeat Yourself) principle and the SOLID principle which we will learn about in this part of the course.

 

# SOLID Principles

The SOLID design principles encourage us to create more maintainable, understandable and flexible software.

### Single Responsibility Principle

Entities should have one responsibility 

### Open-Closed Principle

 Entities should be open to extensions but closed to modifications

### Liskov Substitution Principle

If class A is a subtype of class B, then we should be able to replace B with A without disrupting the behavior of our program.

### Interface Segregation

Entities should not be forced to use interfaces they don’t use. Large interfaces should be split into smaller ones.

### Dependency Inversion

High level modules should not depend on low level modules, both should depend on abstractions.

### SRP

```swift
// Single Responsitiblity

struct User {
    
    var name: String
    var profileName: String
    
    init(name: String, profileName: String) {
        self.name = name
        self.profileName = profileName
    }
    
    mutating func changeName(to name: String) {
        self.name = name
    }
    
    mutating func changeProfileName(to profileName: String) {
        self.profileName = profileName
    }
    
}

struct Account {
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func createdAccount() {
        print("account Created")
    }
    
    func loginAccount() {
        print("logged into account")
    }
    
    func logoutAccount() {
        print("logged out of account")
    }
    
}
```

### OCP

```swift
// Open-Closed Principle
protocol Instrument {
    var brandName: String { get set }
    var model: String { get set }
}

class BasseGuitar: Instrument {
    
    var brandName: String
    var model: String
    
    init(brandName: String, model: String) {
        self.brandName = brandName
        self.model = model
    }
    
}

class FlameGuitar: Instrument {

    var brandName: String
    var model: String
    var flame: String
    
    init(brandName: String, model: String, flame: String) {
        self.brandName = brandName
        self.model = model
        self.flame = flame
    }
    
}

class WaterGuitar: Instrument {

    var brandName: String
    var model: String
    var waterVolume: Int
    
    init(brandName: String, model: String, waterVolume: Int) {
        self.brandName = brandName
        self.model = model
        self.waterVolume = waterVolume
    }
    
}
```

### LSP

```swift
// Listkov Subsitution Principle
protocol Polygon {
    var area: Float { get }
    
}

class Rectangle: Polygon {
    
    var width: Float = 0
    
    var length: Float = 0
    
    init(length: Float, width: Float) {
        self.length = length
        self.width = width
    }
    
    var area: Float {
        return width * length
    }
}

class Square: Polygon {
    
    var side: Float = 0
    
    init(side: Float) {
        self.side = side
    }
    
    var area: Float {
        return side * side
    }
    
}

func printArea(ofPolygon polygon: Polygon) {
    print(polygon.area)
}

let rectangle = Rectangle(length: 10, width: 2)
printArea(ofPolygon: rectangle)

let square = Square(side: 2)
printArea(ofPolygon: square)
```

### ISP

```swift
// Interface Segregation Principle
protocol Vehicle {
    func accelerate()
}

protocol Engine {
    func turnEngineOn()
}

class MotorCar: Vehicle, Engine {
    
    func turnEngineOn() {
        
    }
    
    func accelerate() {
        
    }
    
}

class HoreseDrawCarriage: Vehicle {

    func accelerate() {
        
    }
    
}
```

### DIP

```swift
// Dependency Inversion Principle
protocol CloudService {
    func fetchData(url: String) -> [String]
}

struct FirebaseService: CloudService {
    
    func observeSingleEvent(forRef: String) -> [String] {
        return ["Post"]
    }
    
    func fetchData(url: String) -> [String] {
        return observeSingleEvent(forRef: url)
    }
    
}

struct ParseService: CloudService {
    
    func fetchData(url: String) -> [String] {
        return ["Post"]
    }
    
}

class UserFeed {
    
    private let data: CloudService
    
    init(data: CloudService) {
        self.data = data
    }
    
    func getUserFeedData(url: String) {
        data.fetchData(url: url)
    }
    
}

let parseService = ParseService()

let userFeedService = UserFeed(data: parseService)
userFeedService.getUserFeedData(url: "url")
```

# Singleton

The singleton Design Pattern is a creational design pattern. It ensures only one object of a particular class is ever created.

```swift
import UIKit
import CoreGraphics

enum ThemeSetting {
    
    case darkMode, lightMode
    
    var description: String {
        switch self {
        case .darkMode:
            return "Dark Mode is active"
        case .lightMode:
            return "Light Mode is active"
        }
    }
    
}

class Settings {
    
    static let shared = Settings()
    
    private(set) var theme: ThemeSetting = .lightMode
    private(set) var font = UIFont.systemFont(ofSize: 12)
    
    private init() {}
    
    func changeTheme(to theme: ThemeSetting) {
        self.theme = theme
    }
    
    func changeFontSize(to fontSize: Int) {
        self.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
    
}

Settings.shared.theme.description
Settings.shared.changeTheme(to: .darkMode)
Settings.shared.theme.description
```
# Delegate

According to Apple, “Delegation is a simple and powerful pattern in which one object in a program acts on behalf of, or in coordination with, another object”. A delegation design pattern hands over responsibility to some other entity.

```swift
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
```
# Extension

Extensions allow you to add new functionality to an existing entity.

```swift
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
```
# Observer

The observer design pattern is used to inform other entities of changes to its state

```swift
import UIKit
import Foundation

protocol ScoreObserver {
    func scoreUpdate()
}

enum Team: String {
    case barcelone, juventus
}

class Player {

    var name: String
    let team: Team
    var goalCount = 0
    var scoreObserver: ScoreObserver?
    
    init(name: String, team: Team) {
        self.name = name
        self.team = team
    }

    func didScore() {
        goalCount += 1
        scoreObserver?.scoreUpdate()
    }
    
}

class Game: ScoreObserver {
    
    var players = [Player]()
    
    init(players: [Player]) {
        print("game started")
        self.players = players
    }
    
    func scoreUpdate() {
        
        var barceloneScore = 0
        var juventusScore = 0
        
        for player in players {
            switch player.team {
            case .barcelone:
                barceloneScore += player.goalCount
            case .juventus:
                juventusScore += player.goalCount
            }
        }
        
        print("Barcelone \(barceloneScore) - Juventus \(juventusScore)")
        
    }
    
}

let messi = Player(name: "Messi", team: .barcelone)
let ronaldo = Player(name: "Ronaldo", team: .juventus)
let game = Game(players: [messi, ronaldo])
messi.scoreObserver = game
ronaldo.scoreObserver = game

messi.didScore()
ronaldo.didScore()
messi.didScore()
ronaldo.didScore()
```
# Adapter

The adapter is a structural design pattern that allows entities that would otherwise be incompatible with one another to be linked 

```swift
import UIKit

struct OldLocation {
    var xPosition: Double
    var yPosition: Double
}

struct NewLocation {
    var oldLocation: OldLocation
    var latitude: Double {
        return oldLocation.xPosition
    }
    var longitude: Double {
        return oldLocation.yPosition
    }
}

let oldLocation = OldLocation(xPosition: 23.0, yPosition: 34.2)
let newLocation = NewLocation(oldLocation: oldLocation)
```
# Factory

The factory design pattern is used to encapsulate the implementation details of creating entities which adhere to a common interface.

```swift
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
```
