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
