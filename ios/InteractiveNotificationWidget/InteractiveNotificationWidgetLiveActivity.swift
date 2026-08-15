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

let DEFAULT_PADDING = 10.0;
let DEFAULT_CORNER_RADIUS = DEFAULT_PADDING;

struct InteractiveNotificationWidgetLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            // Lock screen/banner UI goes here
            let backgroundColor = getBackgroundColor(context: context)
            let containerColor = getContainerColor(context: context)
            let textColor = getTextColor(context: context)
            let isPaused = sharedDefault.bool(forKey: context.attributes.prefixedKey("isPaused"))

            VStack {
                HStack{
                    getShownTime(context: context)
                        .padding(DEFAULT_PADDING)
                        .background(
                            RoundedRectangle(cornerRadius: 2*DEFAULT_CORNER_RADIUS)
                                .fill(containerColor)
                        )
                    Spacer()
                    createLiveActivityButtons(isPaused: isPaused, textColor: textColor, containerColor: containerColor)
                }.padding(DEFAULT_PADDING)
            }
            .activityBackgroundTint(backgroundColor)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            
            let backgroundColor = getBackgroundColor(context: context)
            
            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                }
            } compactLeading: {
                Text("📚")
            } compactTrailing: {
                getShownTime(context: context)
            } minimal: {
                Text("📚")
            }
            .keylineTint(backgroundColor)
        }
    }
    func createLiveActivityButtons(isPaused: Bool, textColor: Color, containerColor: Color) -> some View {
        let toggleIcon = isPaused ? "play.fill" : "pause.fill"
        return HStack {
            createButton(
                textColor: textColor,
                containerColor: containerColor,
                iconSystemName: toggleIcon,
                action: { }
            )
            createButton(
                textColor: textColor,
                containerColor: containerColor,
                iconSystemName: "stop.fill",
                action: { }
            )
        }
    }
    func createButton(
        textColor: Color,
        containerColor: Color,
        iconSystemName: String,
        action: @escaping () -> Void
    ) -> some View  {
        return Button(action: action) {
            Image(systemName: iconSystemName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(DEFAULT_PADDING)
                .foregroundColor(textColor)
                .background(containerColor,
                        in: RoundedRectangle(cornerRadius: DEFAULT_CORNER_RADIUS)
                )
        }
        .buttonStyle(.plain)
    }

    func getShownTime(context: ActivityViewContext<LiveActivitiesAppAttributes>) -> Text {
        let currentSegmentStartTime = Int(sharedDefault.string(forKey: context.attributes.prefixedKey("currentSegmentStartTime")) ?? "0") ?? 0
        let accumulatedSeconds = Int(sharedDefault.string(forKey: context.attributes.prefixedKey("accumulatedSeconds")) ?? "0") ?? 0
        let isPaused = sharedDefault.bool(forKey: context.attributes.prefixedKey("isPaused"))
        
        let tempStart = Date(timeIntervalSince1970: Double(currentSegmentStartTime)/1000).addingTimeInterval(-Double(accumulatedSeconds))
    
        let shownText = if (isPaused) {
            Text(formatTime(seconds: accumulatedSeconds))
        } else {
            Text(timerInterval: tempStart...Date.distantFuture, countsDown: false)
        }
        
        return shownText
            .font(.title)
            .bold()
            .foregroundStyle(getTextColor(context: context))
        
    }
    func formatTime(seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        
        return String(format: "%d:%02d", mins, secs)
    }
    func getBackgroundColor(context: ActivityViewContext<LiveActivitiesAppAttributes>) -> Color {
        let backgroundColor = sharedDefault.integer(forKey: context.attributes.prefixedKey("backgroundColor"))
        return Color.init(argb: backgroundColor)
    }
    func getContainerColor(context: ActivityViewContext<LiveActivitiesAppAttributes>) -> Color {
        let containerColor = sharedDefault.integer(forKey: context.attributes.prefixedKey("containerColor"))
        return Color.init(argb: containerColor)
    }
    func getTextColor(context: ActivityViewContext<LiveActivitiesAppAttributes>) -> Color {
        let textColor = sharedDefault.integer(forKey: context.attributes.prefixedKey("textColor"))
        return Color.init(argb: textColor)
    }
}


extension LiveActivitiesAppAttributes {
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}

extension Color {
    init(argb: Int) {
        let alpha = Double((argb >> 24) & 0xFF) / 255
        let red = Double((argb >> 16) & 0xFF) / 255
        let green = Double((argb >> 8) & 0xFF) / 255
        let blue = Double((argb) & 0xFF) / 255
        
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
