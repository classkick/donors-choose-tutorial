//
//  Proposal.swift
//  DonorsChoose
//
//  Created by Tim Luo on 11/16/15.
//  Copyright © 2015 MyOrg. All rights reserved.
//

import Foundation

// An enumeration reflecting how the user feels towards a proposal
enum LikeState {
    case Like
    case Dislike
    case Neutral
}

// Class representing a Proposal, a fundable proposition of some project.
class Proposal : CustomStringConvertible {
    var title: String
    var photoUrl: String?
    var shortDescription: String
    var totalPrice: Double

    // Percent as a fraction of 1, e.g. 0.96, not 96%
    var percentFunded: Double

    var fundedAmount: Double {
        get {
            return self.totalPrice * self.percentFunded
        }
    }

    var likeState: LikeState

    // A string representation of this object. Requires this class to conform to CustomStringConvertible
    var description: String {
        return "Proposal:\ntitle: \(self.title)\nphotoUrl:\(self.photoUrl)\nshortDescription:\(self.shortDescription)\ntotalPrice:\(self.totalPrice)\npercentFunded:\(self.percentFunded)\nlikeState: \(self.likeState)\n"
    }

    // Initializer that takes in a JSON representation of a single proposal
    convenience init(json: JSON) {
        let title = json["title"].stringValue
        let photoUrl = json["thumbImageURL"].string
        let shortDescription = json["shortDescription"].stringValue
        let totalPrice = json["totalPrice"].doubleValue
        let percentFunded = json["percentFunded"].doubleValue * 0.01

        self.init(title: title, photoUrl: photoUrl, shortDescription: shortDescription, totalPrice: totalPrice, percentFunded: percentFunded)
    }

    // Standard initializer
    init(title: String, photoUrl: String?, shortDescription: String, totalPrice: Double, percentFunded: Double) {
        self.title = title
        self.photoUrl = photoUrl
        self.shortDescription = shortDescription
        self.totalPrice = totalPrice
        self.percentFunded = percentFunded
        self.likeState = .Neutral
    }

}
