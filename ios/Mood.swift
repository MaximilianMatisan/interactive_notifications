//
//  Mood.swift
//  Runner
//
//  Created by Maximilian Matisan on 30.08.26.
//

enum Mood: String, CaseIterable {
    case perfect
    case good
    case normal
    case bad
    case miserable
    
    var emoji: String {
        switch self {
            case .perfect: return "🤩"
            case .good: return "😊"
            case .normal: return "😐"
            case .bad: return "😞"
            case .miserable: return "😭"
        }
    }
}
