//
//  BCBeaconsViewController.swift
//  BCSampleSwift
//
//  Created by Adrian Chojnacki on 14/12/16.
//  Copyright © 2016 Upnext. All rights reserved.
//

import UIKit

class BCBeaconsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!

    var delegate: BCBeaconsViewControllerDelegate?
    
    private var beacons : [BCLBeacon] = []
    private var rangedBeacons : [BCLBeacon] = []
    private var otherBeacons : [BCLBeacon] = []
    private let BCBeaconCellIdentifier = "BeaconCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNoItemsErrorLabel()
        tableView!.tableFooterView = UIView()
    }
    
    func startedLoading() {
        hideNoItemsErrorLabel()
        self.tableView?.isHidden = true;
        self.activityIndicator.startAnimating()
    }

    func endLoading() {
        self.tableView?.isHidden = false;
        self.activityIndicator.stopAnimating()
        
        if(!(self.beacons.count > 0)) {
            showNoItemsErrorLabel()
        }
    }
    func showNoItemsErrorLabel() {
        self.errorLabel.isHidden = false
    }
    
    func hideNoItemsErrorLabel() {
        self.errorLabel.isHidden = true
    }

    func set(beacons: [BCLBeacon]?) {
        self.beacons = beacons != nil ? beacons! : [BCLBeacon]();
        //sort ranged and not ranged beacons
        self.rangedBeacons = []
        self.otherBeacons = []
        for beacon in self.beacons {
            if beacon.rssi != 0 {
                self.rangedBeacons += [beacon]
            } else {
                self.otherBeacons += [beacon]
            }
        }
        
        self.tableView?.reloadData();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSections = 0;
        if (self.rangedBeacons.count > 0) {
            numberOfSections += 1
        }
        
        if (self.otherBeacons.count > 0) {
            numberOfSections += 1
        }
        
        self.errorLabel.isHidden = (self.beacons.count > 0 || (self.tableView?.isHidden)!)
        return numberOfSections;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 0
        
        switch section {
            case 0:
                if (self.rangedBeacons.count > 0) {
                    result = self.rangedBeacons.count
                } else {
                    result = self.otherBeacons.count
                }
                break
            case 1:
                result = self.otherBeacons.count
                break
            default:
                break
        }
        
        return result;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var beacon :BCLBeacon?
        if (indexPath.section == 0 && self.rangedBeacons.count > 0) {
            beacon = self.rangedBeacons[indexPath.row]
        } else {
            beacon = self.otherBeacons[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: BCBeaconCellIdentifier)! as! BCBeaconCell;
        cell.configure(beacon: beacon!);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                if self.rangedBeacons.count > 0 {
                    return "Ranged Beacons"
                } else {
                    return nil;
                }
            default:
                return "Other"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(white: 0.95, alpha: 1.0)
    }
    
    @IBAction func reloadButtonPressed(_ sender: Any) {
            self.delegate?.reloadButtonPressed()
    }
}

protocol BCBeaconsViewControllerDelegate {
    func reloadButtonPressed()
}
