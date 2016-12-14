//
//  BCTabBarController.swift
//  BCSampleSwift
//
//  Created by Adrian Chojnacki on 14/12/16.
//  Copyright © 2016 Upnext. All rights reserved.
//

import UIKit

class BCTabBarController: UITabBarController, BCLBeaconCtrlDelegate {

    var beaconCtrl: BCLBeaconCtrl?

    override func viewDidLoad() {
        super.viewDidLoad()

        BCLBeaconCtrl.setupBeaconCtrl(withClientId: "9daf7a6e4140e4e5884912b38c27685688756c4ba9768cf567842c203fb73adc", clientSecret: "172368830e229c0f269c0fe54b019ea3ed35254bf9fdbc63a6152e924852c188", userId: "testUser", pushEnvironment:BCLBeaconCtrlPushEnvironment.none, pushToken: nil) { beaconCtrl, isRestoredFromCache, error in
            if (error != nil) {
                beaconCtrl?.delegate = self;
                self.beaconCtrl = beaconCtrl!;
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
