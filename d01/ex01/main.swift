let card: Card = Card(color: Color.Spades, value: Value.Queen)
let card2: Card = Card(color: Color.Spades, value: Value.Jack)
let card3: Card = Card(color: Color.Spades, value: Value.Queen)

print("First card color =", card.color)
print("First card value =", card.value)
print("Description of first card :", card)

print("-- isEqual test --")
print("Should return false (cards not equal) ->", card.isEqual(card2))
print("Should return true (cards are identical) ->", card.isEqual(card3))

print("-- == test --")
print("Should return false (cards not equal) ->", card == card2)
print("Should return true (cards are identical) ->", card == card3)
