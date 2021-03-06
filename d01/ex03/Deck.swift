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
        var oldDeck: [Card] = self
        var shuffledDeck: [Card] = []
        for i in (0 ..< 52).reversed() {
            let rand = Int(arc4random_uniform(UInt32(i + 1)))
            shuffledDeck.append(oldDeck[rand])
            oldDeck.remove(at: rand)
        }
        return shuffledDeck
    }
}
