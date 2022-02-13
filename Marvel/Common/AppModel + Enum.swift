//
//  AppModel.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation

enum FetchLimt : String {
    case twenty = "20"
    case forty = "40"
    case fifty = "50"
}

struct RequestStatus {
    var success: Bool
    var message: String?
    var interaction: Bool
    
    init(success : Bool, message: String?,interaction:Bool = false) {
        self.success = success
        self.message = message
        self.interaction = interaction
    }
}
