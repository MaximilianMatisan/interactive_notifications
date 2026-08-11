//
//  InteractiveNotificationWidgetLiveActivity.swift
//  InteractiveNotificationWidget
//
//  Created by Maximilian Matisan on 10.08.26.
//

import ActivityKit
import WidgetKit
import SwiftUI

// Create shared default with custom group
let sharedDefault = UserDefaults(suiteName: "group.maxi.test.interactivenotification.a")!

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
  public typealias LiveDeliveryData = ContentState // don't forget to add this line, otherwise, live activity will not display it.

  public struct ContentState: Codable, Hashable { }

  var id = UUID()
}

struct InteractiveNotificationWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            // Lock screen/banner UI goes here
            let greeting = sharedDefault.string(forKey: context.attributes.prefixedKey("greeting"))!
            VStack {
                Text("Text: \(greeting)")
            }
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom ")
                    // more content
                }
            } compactLeading: {
                Text("Zeit")
            } compactTrailing: {
                Text("2:04")
            } minimal: {
                Text("???")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LiveActivitiesAppAttributes {
  func prefixedKey(_ key: String) -> String {
    return "\(id)_\(key)"
  }
}
