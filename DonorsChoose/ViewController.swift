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
        // Get some search results in the form of a JSON response, and then print that.
        let resultsJSON = RestApiManager.sharedInstance.donorsChooseSearch(maxNumResults: 1, keywords: "Chicago")
        print(resultsJSON)
    }

}

