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
    var actions = [BCLAction]()
    private let BCEventCellIdentifier = "EventCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BCEventCellIdentifier)! as! BCEventCell
        cell.configure(event: self.actions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }

    func set(actions: [BCLAction]) {
        self.actions = actions
        self.tableView?.reloadData();
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
