//
//  RestApiManager.swift
//  DonorsDraft
//
//  Created by Andrew Rowland on 11/16/15.
//  Copyright © 2015 Andrew Rowland. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()

    func donorsChooseSearch(startIndex: UInt = 0, maxNumResults: UInt = 10, showSynopsis: Bool = false, keywords: String...) -> JSON? {
        var searchRequest = "http://api.donorschoose.org/common/json_feed.html?APIKey=DONORSCHOOSE&index=\(startIndex)&max=\(maxNumResults)"
        if showSynopsis {
            searchRequest += "&showSynopsis=true"
        }
        if !keywords.isEmpty {
            searchRequest += "&keywords=\(keywords.joinWithSeparator("+"))"
        }
        return makeHTTPGetRequest(searchRequest)
    }

    func makeHTTPGetRequest(path: String) -> JSON? {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)

        let session = NSURLSession.sharedSession()

        // ANTIPATTERN: This semaphore makes this call synchronous, which means it'll wait
        // until a response comes back before proceeding. This is NOT good practice,
        // but we've done it this way for the example as to not have to deal with
        // asynchronous completion blocks in the course of this example.
        let completionSemaphore = dispatch_semaphore_create(0)
        var json: JSON?
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                print(error)
            } else {
                json = JSON(data: data!)
            }
            dispatch_semaphore_signal(completionSemaphore)
        })
        task.resume()

        dispatch_semaphore_wait(completionSemaphore, DISPATCH_TIME_FOREVER)
        return json
    }

    // This isn't as fun, but this is here so that we can still work with some data in case internet stops working.
    func donorsChooseOfflineData() -> JSON? {
        let path = NSBundle.mainBundle().pathForResource("offlineData", ofType: "json")
        let jsonData = NSData(contentsOfFile:path!)
        return JSON(data: jsonData!)
    }
}