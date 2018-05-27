var deck = Deck(shuffle: true)
//print(deck.description)
var deck2 = Deck(shuffle: false)
print(deck2.description)

var c = deck2.draw()!
var d = deck2.draw()!
print(c.description)
print(d.description)
deck2.fold(c: c)
deck2.fold(c: d)

print(deck2.description)
print(deck2.discards.description)
//print(deck2.description)
