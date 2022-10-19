//
//  main.swift
//  TextParser
//
//  Created by Sebastien REMY on 18/10/2022.
//

import Foundation
import NaturalLanguage

@main
struct App {
    static func main() {
        let text = CommandLine.arguments.dropFirst().joined(separator: " ")
        print(text)
        
        print()
        
        let sentiment = sentiment(for: text)
        print("Sentiment analysis: \(sentiment)")
        
        print()
        
        print("Found the followun alternatives:")
        
        for word in text.components(separatedBy: " ") {
            let embeddings = embeddings(for: word)
            print("\t\(word): ", embeddings.formatted(.list(type: .and)))
        }
    }
    
    static func sentiment(for string: String) -> Double {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = string
        let (sentiment, _) = tagger.tag(at: string.startIndex, unit: .paragraph, scheme: .sentimentScore)
        return Double(sentiment?.rawValue ?? "0") ?? 0
    }
    
    static func embeddings(for word: String) -> [String] {
        var results = [String]()
        
        if let embedding = NLEmbedding.wordEmbedding(for: .french) {
            let similardWords = embedding.neighbors(for: word, maximumCount: 10)
            for word in similardWords {
                results.append("\(word.0) has a distance of \(word.1)")
            }
        }
        
        return results
    }
}
