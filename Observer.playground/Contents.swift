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
