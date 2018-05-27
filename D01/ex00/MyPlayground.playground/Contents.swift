//: Playground - noun: a place where people can play

import UIKit

class Card: NSObject
{
    var color: String
    var value: Int
    
    init (color: Color, value: Value)
    {
        self.color = color.rawValue
        self.value = value.hashValue
    }
    
    override var description: String {
        return "\(self.value) de \(color)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Card
        {
            if object.color == self.color && object.value == self.value
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            return false
        }
    }
    static func ==(lhs: Card, rhs: Card) -> Bool {
        
        return lhs.isEqual(rhs)
    }
}

enum    Color: String{
    case Spade = "pique"
    case Diamond = "carreau"
    case Heart = "coeur"
    case Club = "trefle"
    static let allColors: [Color] = [Spade, Diamond, Heart, Club]
}


enum    Value: Int{
    case As = 1
    case Deux = 2
    case Trois = 3
    case Quatre = 4
    case Cinq = 5
    case Six = 6
    case Sept = 7
    case Huit = 8
    case Neuf = 9
    case Dix = 10
    case Valet = 11
    case Dame = 12
    case Roi = 13
    
    static let allValues: [Value] = [As, Deux, Trois, Quatre, Cinq, Six, Sept, Huit, Neuf, Dix, Valet, Dame, Roi]
}
var c1 = Card(color: Color.Spade, value: Value.Neuf)
var c3 = Card(color: Color.Spade, value: Value.Neuf)
var c2 = Card(color: Color.Heart, value: Value.Neuf)
//print(c1.description)

extension Array
{
    mutating func melange()
    {
        for i in indices
        {
            let j = Int(arc4random_uniform(UInt32(self.count)))
            if (j != i)
            {
                self.swapAt(i,j)
            }
        }
    }
}

class Deck: NSObject{
    init (shuffle: Bool)
    {
        if shuffle == true
        {
            cards.melange()
        }
    }
    
    static let allSpades: [Card] = Value.allValues.map{Card(color:Color.Spade, value:$0)}
    static let allHearts: [Card] = Value.allValues.map{Card(color:Color.Heart, value:$0)}
    static let allDiamonds: [Card] = Value.allValues.map{Card(color:Color.Diamond, value:$0)}
    static let allClubs: [Card] = Value.allValues.map{Card(color:Color.Club, value:$0)}
    static let allCards: [Card] = allSpades + allHearts + allDiamonds + allClubs
    var cards: [Card] = allCards
    var discards: [Card] = []
    var outs: [Card] = []
    
    override var description: String {
        var cardsList = "Dans cards de Deck nous avons:\n"
        for cartes in self.cards
        {
            cardsList += "\(cartes.description)\n"
        }
        return cardsList
    }
    
    func draw() -> Card? {
        outs.append(self.cards[0])
        cards.remove(at:0)
        return self.outs.last
    }
    
    func fold(c: Card)
    {
        let i = outs.index(of: c)
            if i != nil
            {
                discards.append(c)
                outs.remove(at: i!)
            }
    }
    
}

var deck = Deck(shuffle: true)
//print(deck.description)
//c1.isEqual(c3)
var deck2 = Deck(shuffle: false)
//var index = 0
//while index <  52
//{
//    let card = deck.draw()!
//
//    index += 1
//    print("on tire: \(card.description)")
//    print("il reste \(deck.outs.count) cartes")
//
////    print("There is \(deck.discards.count) card(s) in discards")
//
////    deck.fold(c: card)
////    deck.fold(c: card)
//
////    print("There is \(deck.discards.count) card(s) in discards")
//}
print(deck2.description)
var c = deck2.draw()!
var d = deck2.draw()!

print(deck2.description)
print(c.description)
print(d.description)
deck2.fold(c: c)
print(deck2.description)
print(deck2.discards.description)
