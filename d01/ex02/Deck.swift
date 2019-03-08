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

    var cards: [Card] = allCards
    var discards: [Card] = []
    var outs: [Card] = []

    init(toShuffle: Bool) {
        if toShuffle == true {
            self.cards = Deck.allCards.shuffle()
        }
    }

    override var description: String {
        return self.cards.description
    }

    func draw() -> Card? {
        let cardToMove: Card? = cards.first
        if let cardToMoveUnwrap: Card = cardToMove {
            self.outs.append(cardToMoveUnwrap)
            self.cards.remove(at: 0)
        }
        return cardToMove
    }

    func fold(c: Card) {
        if self.outs.contains(c) {
            self.discards.append(c)
            if let index = self.outs.index(of: c) {
                self.outs.remove(at: index)
            }
        }
    }
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
