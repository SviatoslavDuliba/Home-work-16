//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Duliba Sviatoslav on 20.02.2022.
//

import Foundation
import UIKit

class Emoji: NSCoding {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsPath.appendingPathComponent(PropertyKye.emoji).appendingPathExtension("plist")
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
    struct PropertyKye {
        static let symbol = "symbol"
        static let name = "name"
        static let description = "description"
        static let usage = "usage"
        static let emoji = "emoji"
    }


required convenience init?(coder aDecoder: NSCoder) {
   
    guard let symbol = aDecoder.decodeObject(forKey: PropertyKye.symbol) as? String,
          let name = aDecoder.decodeObject(forKey: PropertyKye.name) as? String,
          let description = aDecoder.decodeObject(forKey: PropertyKye.description) as? String,
          let usage = aDecoder.decodeObject(forKey: PropertyKye.usage) as? String
    else {
        return nil
    }
    self.init(symbol: symbol,name: name,description: description,usage: usage)
}
    func encode(with aCoder: NSCoder)  {
    aCoder.encode(symbol, forKey: PropertyKye.symbol)
    aCoder.encode(name, forKey: PropertyKye.name)
    aCoder.encode(description, forKey: PropertyKye.description)
    aCoder.encode(usage, forKey: PropertyKye.usage)

}
    
}


extension Emoji {
    
   static func saveToFile (emojis: [Emoji]) {
        NSKeyedArchiver.archiveRootObject(emojis, toFile: Emoji.archiveURL.path)
    }
    
    static func loadFromFile() -> [Emoji]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Emoji.archiveURL.path) as? [Emoji]
    }
    static func loadSampleEmojis() -> [Emoji] {
        
        let emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face", usage: "displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes", usage: "attractive"),
        Emoji(symbol: "👨‍💻", name: "Developer", description: "A person working on Mackbook", usage: "programming"),
        Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle", usage: "something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "Single die", usage: "taking a risk"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other", usage: "studying"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart", usage: "extreme sadness"),
        Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag", usage: "completion"),
        Emoji(symbol: "✅", name: "Check mark", description: "While you have completed something", usage: "completion"),
        Emoji(symbol: "⚽️", name: "Soccer ball", description: "A ball for playing in soccer", usage: "soccer"),
        Emoji(symbol: "🍿", name: "Popcorn", description: "Tasty popcorn", usage: "watching a movie"),
        Emoji(symbol: "🍎", name: "Apple", description: "A red apple", usage: "lunch"),
        Emoji(symbol: "🌞", name: "Sun", description: "A yellow sun with eyes", usage: "good weather"),
        Emoji(symbol: "⚡️", name: "Lighthing", description: "Scary lightning", usage: "bad weather")
        ]
        return emojis
    }
}
