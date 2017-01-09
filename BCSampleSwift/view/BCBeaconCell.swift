//
//  BCBeaconCell.swift
//  BCSampleSwift
//
//  Created by Adrian Chojnacki on 14/12/16.
//  Copyright © 2016 Upnext. All rights reserved.
//

import UIKit

class BCBeaconCell: UITableViewCell {
    
    @IBOutlet weak var beaconNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!

    func configure(beacon: BCLBeacon) {

        if beacon.rssi != 0 {
            self.contentView.alpha = 1.0
            self.distanceLabel.text = String(format:"%.2f", beacon.estimatedDistance) + "m"
        } else {
            self.contentView.alpha = 0.5
            self.distanceLabel.text = nil
        }

        self.uuidLabel.text = beacon.proximityUUID.uuidString
        self.beaconNameLabel.text = beacon.name
    }

}
