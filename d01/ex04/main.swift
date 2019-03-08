func drawingIn(time: Int, deck: Deck) {
    if let drawCard = deck.draw() {
        print("i =", time, "- drawed card ->", drawCard)
    } else {
        print("i =", time, "- drawed card -> No card left")
    }
}

var shuffledDeck: Deck = Deck(toShuffle: true)
var sortedDeck: Deck = Deck(toShuffle: false)
print("Print shuffledDeck :")
print(shuffledDeck)
print("Print sortedDeck :")
print(sortedDeck)

print("\nDrawing 60 times in shuffledDeck:")
for i in 0 ..< 60 {
    drawingIn(time: i, deck: shuffledDeck)
}
print("Print outs of shuffledDeck :")
print(shuffledDeck.outs)
print("Print discards of shuffledDeck :")
print(shuffledDeck.discards)
print("Print cards of shuffledDeck :")
print(shuffledDeck.cards)

print("\nDrawing 3 times in sortedDeck:")
for i in 0 ..< 3 {
    drawingIn(time: i, deck: sortedDeck)
}
print("Print outs of sortedDeck :", sortedDeck.outs)
print("Folding an existing card in outs: (Spades, Ace)")
sortedDeck.fold(c: Card(color: Color.Spades, value: Value.Ace))
print("Print outs of sortedDeck :", sortedDeck.outs)
print("Print discards of sortedDeck :", sortedDeck.discards)
print("Folding an unknown card in outs: (Club, Ace)")
sortedDeck.fold(c: Card(color: Color.Clubs, value: Value.Ace))
print("Print outs of sortedDeck :", sortedDeck.outs)
print("Print discards of sortedDeck :", sortedDeck.discards)
print("Print cards of sortedDeck :")
print(sortedDeck.cards)

