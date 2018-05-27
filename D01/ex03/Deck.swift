import Cocoa

extension Array
{
  mutating func melange()
  {
        for i in indices
        {
            // print(i)
           let j = Int(arc4random_uniform(UInt32(self.count)))
           if (j != i)
           {
               self.swapAt(i,j)
           }
       }
  }
}

class Deck: NSObject{
    static let allSpades: [Card] = Value.allValues.map{Card(color:Color.Spade, value:$0)}
    static let allHearts: [Card] = Value.allValues.map{Card(color:Color.Heart, value:$0)}
    static let allDiamonds: [Card] = Value.allValues.map{Card(color:Color.Diamond, value:$0)}
    static let allClubs: [Card] = Value.allValues.map{Card(color:Color.Club, value:$0)}
    static let allCards: [Card] = allSpades + allHearts + allDiamonds + allClubs
}
