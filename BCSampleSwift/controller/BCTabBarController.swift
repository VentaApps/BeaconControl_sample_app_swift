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
    private var events = [BCEvent]() {
        didSet {
            self.eventsViewController?.set(events: events)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        BCLBeaconCtrl.setupBeaconCtrl(withClientId: "95f223e4ff83774ecd1af21bc9b67df33417f5af550ee528f61c81100dc63c66", clientSecret: "eabeb9a49b88a5b4441286e3f4ed3b0ef1896b1a50a9cdfd6d8ac5332dcd47ef", userId: "testUser", pushEnvironment:BCLBeaconCtrlPushEnvironment.none, pushToken: nil) { beaconCtrl, isRestoredFromCache, error in
            DispatchQueue.main.async {
                if (error == nil) {
                    let delegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.beaconCtrl = beaconCtrl
                    beaconCtrl?.delegate = self
                    self.beaconCtrl = beaconCtrl!
                    self.beaconCtrl!.startMonitoringBeacons()
                }
            }
        }

        //create timer for refreshing beacons state
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.reloadBeacons()
            }
        } else {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(reloadBeacons), userInfo: nil, repeats: true)
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
    
    func reloadBeacons() {
        let beaconsArray = self.beaconCtrl?.beaconsSortedByDistance();
        self.beaconsViewController?.set(beacons: beaconsArray);
    }
    
    //MARK: - BeaconCtrl Delegate
    
    func didPerform(_ action: BCLAction!) {
        self.events += [BCEvent(action: action)]
    }

    //MARK: - Actions

    @IBAction func didPressReloadButton() {
        self.beaconCtrl?.fetchConfiguration { v in  }
    }

}
