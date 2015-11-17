//
//  Proposal.swift
//  DonorsChoose
//
//  Created by Tim Luo on 11/16/15.
//  Copyright © 2015 MyOrg. All rights reserved.
//

import Foundation

enum LikeState {
    case Like
    case Dislike
    case Neutral
}

class Proposal {
    var title: String?
    var photoUrl: String?
    var shortDescription: String?
    var totalPrice: Double?
    var percentFunded: Double?

    var likeState: LikeState

    init() {
        self.title = nil
        self.photoUrl = nil
        self.shortDescription = nil
        self.likeState = .Neutral

        
    }

}
