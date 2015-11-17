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

                if proposal.likeState == LikeState.Like {
                    likeButtonOn()
                } else if proposal.likeState == LikeState.Dislike {
                    dislikeButtonOn()
                } else {
                    bothButtonsOff()
                }
            }
        }
    }

    @IBAction func didTapLike(sender: UIButton) {
        self.proposal?.likeState = .Like
        likeButtonOn()
    }


    @IBAction func didTapDislike(sender: UIButton) {
        self.proposal?.likeState = .Dislike
        dislikeButtonOn()
    }

    @IBAction func didTapClear(sender: UIButton) {
        self.proposal?.likeState = .Neutral
        bothButtonsOff()
    }

    private func likeButtonOn() {
        self.likeButton.titleLabel?.font = UIFont.boldSystemFontOfSize(28)
        self.dislikeButton.titleLabel?.font = UIFont.systemFontOfSize(15)
    }

    private func dislikeButtonOn() {
        self.dislikeButton.titleLabel?.font = UIFont.boldSystemFontOfSize(22)
        self.likeButton.titleLabel?.font = UIFont.systemFontOfSize(15)
    }

    private func bothButtonsOff() {
        self.likeButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.dislikeButton.titleLabel?.font = UIFont.systemFontOfSize(15)
    }
}
