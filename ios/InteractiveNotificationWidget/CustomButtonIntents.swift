//
//  CustomButtonIntents.swift
//  Runner
//
//  Created by Maximilian Matisan on 17.08.26.
//

import WidgetKit
import AppIntents

struct ToggleTimerIntent: LiveActivityIntent {
    static var title: LocalizedStringResource { "Toggle timer" }
    
    func perform() async throws -> some IntentResult {
        .result()
    }
}

struct EndTimerIntent: LiveActivityIntent {
    static var title: LocalizedStringResource { "End timer" }
    
    func perform() async throws -> some IntentResult {
        .result()
    }
}
