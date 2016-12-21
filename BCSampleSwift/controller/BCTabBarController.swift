//
//  BCTabBarController.swift
//  BCSampleSwift
//
//  Created by Adrian Chojnacki on 14/12/16.
//  Copyright © 2016 Upnext. All rights reserved.
//

import UIKit

class BCTabBarController: UITabBarController, BCLBeaconCtrlDelegate {

    private var beaconCtrl: BCLBeaconCtrl?
    private var beaconsViewController: BCBeaconsViewController?
    private var eventsViewController: BCActionsViewController?
    private var actions = [BCLAction]() {
        didSet {
            self.eventsViewController?.set(actions: actions)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        BCLBeaconCtrl.setupBeaconCtrl(withClientId: "95f223e4ff83774ecd1af21bc9b67df33417f5af550ee528f61c81100dc63c66", clientSecret: "eabeb9a49b88a5b4441286e3f4ed3b0ef1896b1a50a9cdfd6d8ac5332dcd47ef", userId: "testUser", pushEnvironment:BCLBeaconCtrlPushEnvironment.none, pushToken: nil) { beaconCtrl, isRestoredFromCache, error in
            if (error == nil) {
                beaconCtrl?.delegate = self;
                self.beaconCtrl = beaconCtrl!;
                self.beaconCtrl!.startMonitoringBeacons();
            }
        }

        //create timer for refreshing beacons state
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let beaconsArray = self.beaconCtrl?.beaconsSortedByDistance();
            self.beaconsViewController?.set(beacons: beaconsArray);
        }

        //set up vc properties
        for controller in self.viewControllers! {
            if let destinationVC = controller as? BCBeaconsViewController {
                self.beaconsViewController = destinationVC
            } else if let destinationVC = controller as? BCActionsViewController {
                self.eventsViewController = destinationVC
            }
        }
    }

    func notify(_ action: BCLAction!) {
        self.actions += [action];

    }
    
    func didPerform(_ action: BCLAction!) {
        self.actions += [action];
    }

}
