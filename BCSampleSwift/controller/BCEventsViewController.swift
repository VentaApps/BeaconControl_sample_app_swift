//
//  BCEventsViewController.swift
//  BCSampleSwift
//
//  Created by Adrian Chojnacki on 14/12/16.
//  Copyright © 2016 Upnext. All rights reserved.
//

import UIKit

class BCActionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    var events = [BCEvent]()
    private let BCEventCellIdentifier = "EventCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        hideNoItemsErrorLabel()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BCEventCellIdentifier)! as! BCEventCell
        cell.configure(event: self.events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(!(self.events.count > 0)){
            showNoItemsErrorLabel()
        }
        return events.count
    }

    func set(events: [BCEvent]) {
        self.events = events
        self.tableView?.reloadData();
    }
    

    func showNoItemsErrorLabel(){
        self.errorLabel.text = "No events available"
        self.errorLabel.isHidden = false
    }

    func hideNoItemsErrorLabel(){
        self.errorLabel.isHidden = true
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
