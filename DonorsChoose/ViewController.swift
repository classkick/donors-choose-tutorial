//
//  ViewController.swift
//  DonorsChoose
//
//  Created by Tim Luo on 11/16/15.
//  Copyright © 2015 MyOrg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var proposalTableView: UITableView!
    var proposals: [Proposal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // If there are search results, iterate over the returned proposals. For each one, print something out.
        if let resultsJSON = RestApiManager.sharedInstance.donorsChooseSearch(maxNumResults: 3, keywords: "Chicago") {
            // The iterator over a JSON always returns an (index, subJSON), which is why we need the empty first tuple value
            for (_, proposalJSON):(String, JSON) in resultsJSON["proposals"] {
                let proposal = Proposal(json: proposalJSON)
                self.proposals.append(proposal)
            }
        }
    }

    // This is optional and defaults to 1 anyway, so we don't really need this.
    // But we've added it here to show how to set the number of sections, how to reference
    // a table view connected as an outlet, and being explicit about the number of sections.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == self.proposalTableView {
            return 1
        }
        return 0
    }

    // UITableViewDataSource method defining the number of rows in the section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.proposals.count
    }

    // UITableViewDataSource method specifying what the cell should look like for each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var proposalCell = tableView.dequeueReusableCellWithIdentifier("proposalCell") as? ProposalTableViewCell
        if proposalCell == nil {
            proposalCell = ProposalTableViewCell()
        }
        let proposal = self.proposals[indexPath.row]
        proposalCell!.proposal = proposal
        return proposalCell!
    }
}

