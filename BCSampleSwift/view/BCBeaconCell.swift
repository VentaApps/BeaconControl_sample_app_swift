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

    func configure(beacon:BCLBeacon) {
        self.beaconNameLabel.text = beacon.name;
    }

}
