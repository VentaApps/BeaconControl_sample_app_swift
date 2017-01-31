//
//  BCBeaconsViewController.swift
//  BCSampleSwift
//
//  Created by Adrian Chojnacki on 14/12/16.
//  Copyright © 2016 Upnext. All rights reserved.
//

import UIKit

class BCBeaconsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!

    var delegate: BCBeaconsViewControllerDelegate?
    
    private var beacons : [BCLBeacon] = []
    private let BCBeaconCellIdentifier = "BeaconCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        hideNoItemsErrorLabel()
    }
    
    func startedLoading(){
        hideNoItemsErrorLabel()
        self.tableView.isHidden = true;
        self.activityIndicator.startAnimating()
    }
    func endLoading(){
        self.tableView.isHidden = false;
        self.activityIndicator.stopAnimating()
        
        if(!(self.beacons.count > 0)){
            showNoItemsErrorLabel()
        }
    }
    func showNoItemsErrorLabel(){
        self.errorLabel.text = "No beacons available"
        self.errorLabel.isHidden = false
    }
    
    func hideNoItemsErrorLabel(){
        self.errorLabel.isHidden = true
    }

    func set(beacons: [BCLBeacon]?) {
        self.beacons = beacons != nil ? beacons! : [BCLBeacon]();
        self.tableView.reloadData();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beacons.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BCBeaconCellIdentifier)! as! BCBeaconCell;
        let beacon = self.beacons[indexPath.row];
        cell.configure(beacon: beacon);
        return cell;
    }
    
    @IBAction func reloadButtonPressed(_ sender: Any) {
            self.delegate?.reloadButtonPressed()
    }
}



protocol BCBeaconsViewControllerDelegate {
    func reloadButtonPressed()
}
