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
