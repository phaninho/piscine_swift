import Cocoa

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
