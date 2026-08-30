//
//  SelfAssessmentIntents.swift
//  Runner
//
//  Created by Maximilian Matisan on 30.08.26.
//

import WidgetKit
import AppIntents
import UserNotifications

struct SelfAssessmentIntent: LiveActivityIntent {
    static var title: LocalizedStringResource { "Self Assessment" }
    static var isDiscoverable: Bool { false }
    
    @Parameter(title:"Activity Id")
    var activityId: String
    
    @Parameter(title:"Mood")
    var moodString: String
    
    init() {}
    init(activityId: String, moodString: String) {
        self.activityId = activityId
        self.moodString = moodString
    }

    func perform() async throws -> some IntentResult {
        SharedTimerState.safeSelfAssessment(id: activityId, moodString: moodString)
        await SharedTimerState.end(id: activityId)
        return .result()
    }
}
