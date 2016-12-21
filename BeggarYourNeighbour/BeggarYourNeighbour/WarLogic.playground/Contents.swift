//: Playground - noun: a place where people can play

import Cocoa

// Create an enumeration for the suits of a deck of cards
enum Suit : String {
    
    case hearts     = "❤️"
    case diamonds   = "♦️"
    case spades     = "♠️"
    case clubs      = "♣️"
    
    // Given a value, returns the suit
    static func glyph(forHashValue : Int) -> String {
        switch forHashValue {
        case 0 :
            return Suit.hearts.rawValue
        case 1 :
            return Suit.diamonds.rawValue
        case 2 :
            return Suit.spades.rawValue
        case 3 :
            return Suit.clubs.rawValue
        default:
            return Suit.hearts.rawValue
        }
    }
    
}

// Play with the enumeration a bit to see what it gives us
Suit.hearts.hashValue
Suit.hearts.rawValue

// Create a new datatype to represent a playing card
struct Card {
    
    var value : Int
    var suit : Int
    
    // Initializer accepts arguments to set up this instance of the struct
    init(value : Int, suit : Int) {
        self.value = value
        self.suit = suit
    }
    
}

// Initalize a deck of cards
var deck : [Card] = []
for suit in 0...3 {
    for value in 2...14 {
        var card = Card(value: value, suit: suit)
        deck.append(card)
    }
}

// Iterate over the deck of cards
for card in deck {
    print("Suit is \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
}

// Initialize hands
var playerHand : [Card] = []
var computerHand : [Card] = []

// "Shuffle" the deck and give half the cards to the player
while deck.count > 26 {
    
    // Generate a random number between 0 and the count of cards still left in the deck
    var position = Int(arc4random_uniform(UInt32(deck.count)))
    
    // Copy the card in this position to the player's hand
    playerHand.append(deck[position])
    
    // Remove the card from the deck for this position
    deck.remove(at: position)
    
}

// Iterate over the player's hand
print("=====================================")
print("All cards in the player's hand are...")
for (value, card) in playerHand.enumerated() {
    print("Card \(value) in player's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
}

// "Shuffle" the deck and give half the cards to the computer
while deck.count > 0 {
    
    // Generate a random number between 0 and the count of cards still left in the deck
    var position = Int(arc4random_uniform(UInt32(deck.count)))
    
    // Copy the card in this position to the computer's hand
    computerHand.append(deck[position])
    
    // Remove the card from the deck for this position
    deck.remove(at: position)
    
}

// Iterate over the computer's hand
print("=====================================")
print("All cards in the computer's hand are...")
for (value, card) in computerHand.enumerated() {
    print("Card \(value) in computer's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
}

// Only plays game until player one either wins or loses
while playerHand.count > 0 && playerHand.count < 52 {
    
    // If player has a higher card
    if playerHand[0].value > computerHand[0].value {
        playerHand.append(computerHand[0])
        computerHand.remove(at: 0)
        playerHand.append(playerHand[0])
        print("=====================================")
        print ("Player's card is higher! Player now has \(playerHand.count) cards.")
        print ("Player \(playerHand.count) - \(computerHand.count) Computer")
    }
    
    // If computer has a higher card
    if computerHand[0].value > playerHand[0].value {
        computerHand.append(playerHand[0])
        playerHand.remove(at: 0)
        computerHand.append(computerHand[0])
        print("=====================================")
        print ("Computer's card is higher! Computer now has \(computerHand.count) cards.")
        print ("Player \(playerHand.count) - \(computerHand.count) Computer")
    }
    
    // If there's a tie
    if computerHand[0].value == playerHand[0].value {
        print("=====================================")
        print ("It's a tie, let war begin!")
        
        // If player wins the war
        if playerHand[4].value > computerHand[4].value {
            playerHand.append(computerHand[0])
            playerHand.append(computerHand[0])
            playerHand.append(computerHand[0])
            playerHand.append(computerHand[0])
            playerHand.append(computerHand[0])
            computerHand.remove(at: 0)
            computerHand.remove(at: 0)
            computerHand.remove(at: 0)
            computerHand.remove(at: 0)
            computerHand.remove(at: 0)
            playerHand.append(playerHand[0])
            print("=====================================")
            print ("Player wins! Player now has \(playerHand.count) cards.")
            print ("Player \(playerHand.count) - \(computerHand.count) Computer")
        }
        
        // If computer wins the war
        if computerHand[4].value > playerHand[4].value {
            computerHand.append(playerHand[0])
            computerHand.append(playerHand[0])
            computerHand.append(playerHand[0])
            computerHand.append(playerHand[0])
            computerHand.append(playerHand[0])
            playerHand.remove(at: 0)
            playerHand.remove(at: 0)
            playerHand.remove(at: 0)
            playerHand.remove(at: 0)
            playerHand.remove(at: 0)
            computerHand.append(computerHand[0])
            print("=====================================")
            print ("Player wins! Player now has \(playerHand.count) cards.")
            print ("Player \(playerHand.count) - \(computerHand.count) Computer")
        }
    }
}

