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
    private var beacons : [BCLBeacon] = []
    private let BCBeaconCellIdentifier = "BeaconCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
