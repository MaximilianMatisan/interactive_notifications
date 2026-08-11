//
//  InteractiveNotificationWidgetBundle.swift
//  InteractiveNotificationWidget
//
//  Created by Maximilian Matisan on 10.08.26.
//

import WidgetKit
import SwiftUI

@main
struct InteractiveNotificationWidgetBundle: WidgetBundle {
    var body: some Widget {
        InteractiveNotificationWidget()
        InteractiveNotificationWidgetControl()
        InteractiveNotificationWidgetLiveActivity()
    }
}
