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
    @IBOutlet weak var dateLabel: UILabel!
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.medium
        return formatter
    }()
    
    func configure(event: BCEvent) {
        self.eventNameLabel.text = event.action.name;
        self.dateLabel.text = BCEventCell.dateFormatter.string(from: event.date)
    }

}
