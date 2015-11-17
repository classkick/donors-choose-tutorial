//
//  ViewController.swift
//  DonorsChoose
//
//  Created by Tim Luo on 11/16/15.
//  Copyright © 2015 MyOrg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // If there are search results, iterate over the returned proposals. For each one, print something out.
        if let resultsJSON = RestApiManager.sharedInstance.donorsChooseSearch(maxNumResults: 3, keywords: "Chicago") {
            // The iterator over a JSON always returns an (index, subJSON), which is why we need the empty first tuple value
            for (_, proposalJSON):(String, JSON) in resultsJSON["proposals"] {
                let proposal = Proposal(json: proposalJSON)
                print(proposal)
            }
        }
    }

}

