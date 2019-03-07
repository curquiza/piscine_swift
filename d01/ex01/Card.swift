import Foundation

class Card : NSObject {

    var color: Color
    var value: Value

    init (color: Color, value: Value) {
        print("Card constructor called.")
        self.color = color
        self.value = value
    }

    override var description: String {
        return "(" + String(value.hashValue) + ", " + color.rawValue + ")"
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let card = object as? Card {
            if (card.color == self.color && card.value == self.value) {
                return true
            }
        }
        return false
    }

    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.isEqual(rhs)
    }
}
