//
//  BCTabBarController.swift
//  BCSampleSwift
//
//  Created by Adrian Chojnacki on 14/12/16.
//  Copyright © 2016 Upnext. All rights reserved.
//

import UIKit

class BCTabBarController: UITabBarController, BCLBeaconCtrlDelegate, BCBeaconsViewControllerDelegate {
    
    var clientID: String?
    var clientSecret: String?

    private var beaconCtrl: BCLBeaconCtrl?
    private var beaconsViewController: BCBeaconsViewController?
    private var eventsViewController: BCActionsViewController?
    private var events = [BCEvent]() {
        didSet {
            self.eventsViewController?.set(events: events)
        }
        
    }
    
    private var timer: Timer?
    
    deinit {
        self.timer?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //create timer for refreshing beacons state
        if #available(iOS 10.0, *) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.reloadBeacons()
            }
        } else {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(reloadBeacons), userInfo: nil, repeats: true)
        }

        //set up vc properties
        for controller in self.viewControllers! {
            if let destinationVC = controller as? BCBeaconsViewController {
                self.beaconsViewController = destinationVC
                self.beaconsViewController?.delegate = self
            } else if let destinationVC = controller as? BCActionsViewController {
                self.eventsViewController = destinationVC
            }
        }
        self.reloadBeacons()
    }
    
    func set(beaconCtrl: BCLBeaconCtrl?) {
        beaconCtrl?.delegate = self
        self.beaconCtrl = beaconCtrl
        self.beaconCtrl?.startMonitoringBeacons()
    }
    
    @objc func reloadBeacons() {
        if (self.beaconCtrl?.configuration.beacons != nil) {
            var beaconsArray = Array(self.beaconCtrl!.configuration.beacons)
            beaconsArray.sort(by: { (firstBeacon, secondBeacon) -> Bool in
                return firstBeacon.estimatedDistance < secondBeacon.estimatedDistance
            })
            self.beaconsViewController?.set(beacons: beaconsArray);
        }
    }

    //MARK: - BeaconCtrl Delegate
    
    func didPerform(_ action: BCLAction!) {
        self.events = [BCEvent(action: action)] + self.events
    }

    //MARK: - BCBeaconsViewController Delegate
    
    func reloadButtonPressed() {
        self.beaconsViewController?.startedLoading()

        self.beaconCtrl?.fetchConfiguration { error in
            DispatchQueue.main.async {
                self.beaconCtrl?.startMonitoringBeacons()
                self.reloadBeacons()
                self.beaconsViewController?.endLoading()
            }
        }
    }

}
