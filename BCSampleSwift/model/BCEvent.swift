//
//  BCEvent.swift
//  BCSampleSwift
//
//  Created by Adrian Chojnacki on 21/12/16.
//  Copyright © 2016 Upnext. All rights reserved.
//

import UIKit

class BCEvent: NSObject {
    let action :BCLAction
    let date: Date
    
    init(action: BCLAction) {
        self.action = action;
        self.date = Date()
    }
    
}
