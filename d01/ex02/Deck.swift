import Foundation

func cardGroup(color: Color) -> [Card] {
    return Value.allValues.map {
        Card(color: color, value: $0)
    }
}

class Deck : NSObject {
    static let allSpades: [Card] = cardGroup(color: Color.Spades)
    static let allDiamonds: [Card] = cardGroup(color: Color.Diamond)
    static let allHearts: [Card] = cardGroup(color: Color.Heart)
    static let allClubs: [Card] = cardGroup(color: Color.Clubs)
    static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
}

extension Array where Element:Card {
    func shuffle() -> [Card] {
        for i in 51 ..>= 0 {
            let rand = Int(arc4random_uniform(i))
        }
        return self
        // return sort { Float($0.value) < Float($1.value) }
    }
}
