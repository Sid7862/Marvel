//
//  AppModel.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 10/02/22.
//

import Foundation

struct RequestStatus
{
    var success: Bool
    var message: String?
    var interaction: Bool
    init(success : Bool, message: String?,interaction:Bool = false) {
        self.success = success
        self.message = message
        self.interaction = interaction
    }
}
