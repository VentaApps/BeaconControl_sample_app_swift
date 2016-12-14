//
//  BCEventCell.swift
//  BCSampleSwift
//
//  Created by Adrian Chojnacki on 14/12/16.
//  Copyright © 2016 Upnext. All rights reserved.
//

import UIKit

class BCEventCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    
    func configure(event:BCLAction) {
        self.eventNameLabel.text = event.name;
    }

}
