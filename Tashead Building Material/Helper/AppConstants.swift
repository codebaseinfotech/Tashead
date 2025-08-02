//
//  AppConstants.swift
//  Tashead Building Material
//
//  Created by Ankit Gabani on 31/05/23.
//

import Foundation
import UIKit

let CURRENT_USER_DATA = "currentUserData"

let CURRENT_MAIN_DATA = "MainData"

let PRIMARY_COLOR = UIColor(red: 71/255, green: 68/255, blue: 85/255, alpha: 1)


class AppManager {
    static var shared = AppManager()
    
    var delivery_day_slot_id: Int = 0
    var booked_slot_time: String = ""
    var delivery_date: String = ""
}
