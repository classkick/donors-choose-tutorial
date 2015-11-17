//
//  ProposalTableViewCell.swift
//  DonorsChoose
//
//  Created by Tim Luo on 11/16/15.
//  Copyright © 2015 MyOrg. All rights reserved.
//

import UIKit

class ProposalTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fundProgressLabel: UILabel!

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var descriptionField: UITextView!

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!

    var proposal: Proposal? {
        didSet {
            if let proposal = proposal {
                self.titleLabel.text = proposal.title
                // The string formats are to round to the nearest whole dollar
                let fundedAmountString = String(format: "%.0f", proposal.fundedAmount)
                let totalPriceString = String(format: "%.0f", proposal.totalPrice)
                self.fundProgressLabel.text = "$\(fundedAmountString) out of $\(totalPriceString) funded"
                self.descriptionField.text = proposal.shortDescription

                // Network requests should be dealt with asynchronously so that
                // the UI doesn't stutter, but won't cover that in this example.
                if let imageURL = proposal.photoUrl {
                    if let url = NSURL(string: imageURL) {
                        if let data = NSData(contentsOfURL: url) {
                            thumbnailImage.image = UIImage(data: data)
                        }        
                    }
                }
            }
        }
    }
}
