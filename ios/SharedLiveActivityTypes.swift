//
//  SharedLiveActivityTypes.swift
//  Runner
//
//  Created by Maximilian Matisan on 16.08.26.
//

import Foundation
import ActivityKit

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
  public typealias LiveDeliveryData = ContentState
  public struct ContentState: Codable, Hashable { }
  var id = UUID()
}

extension LiveActivitiesAppAttributes {
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}
