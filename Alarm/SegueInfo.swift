//
//  SegueInfo.swift
//  Alarm-ios-swift
//
//  Created by Stefano Brandi on 11/06/21.
//

import Foundation

struct SegueInfo {
    var curCellIndex: Int
    var isEditMode: Bool
    var label: String
    var mediaLabel: String
    var mediaID: String
    var repeatWeekdays: [Int]
    var enabled: Bool
    var snoozeEnabled: Bool
}
