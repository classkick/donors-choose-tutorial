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
class Proposal {
    var title: String
    var photoUrl: String?
    var shortDescription: String
    var totalPrice: Double
    var percentFunded: Double

    var likeState: LikeState

    // Initializer that takes in a JSON representation of a single proposal
    convenience init(json: JSON) {
        let title = json["title"].stringValue
        let photoUrl = json["thumbImageURL"].string
        let shortDescription = json["shortDescription"].stringValue
        let totalPrice = json["totalPrice"].doubleValue
        let percentFunded = json["percentFunded"].doubleValue

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
