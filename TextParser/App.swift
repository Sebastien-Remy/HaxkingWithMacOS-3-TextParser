//
//  main.swift
//  TextParser
//
//  Created by Sebastien REMY on 18/10/2022.
//

import Foundation

@main
struct App {
    static func main() {
        let text = CommandLine.arguments.dropFirst().joined(separator: " ")
        print(text)
    }
}
