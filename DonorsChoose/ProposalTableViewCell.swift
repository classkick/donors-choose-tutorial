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
                
                updateButtonUIState()
            }
        }
    }

    @IBAction func didTapLike(sender: UIButton) {
        self.proposal?.likeState = .Like
        updateButtonUIState()
    }


    @IBAction func didTapDislike(sender: UIButton) {
        self.proposal?.likeState = .Dislike
        updateButtonUIState()
    }

    @IBAction func didTapClear(sender: UIButton) {
        self.proposal?.likeState = .Neutral
        updateButtonUIState()
    }
    
    private func updateButtonUIState() {
        removeBorderFromButton(self.likeButton)
        removeBorderFromButton(self.dislikeButton)
        
        if proposal?.likeState == LikeState.Like {
            addBorderToButton(self.likeButton)
        } else if proposal?.likeState == LikeState.Dislike {
            addBorderToButton(self.dislikeButton)
        }
    }

    private func addBorderToButton(button: UIButton) {
        button.layer.borderColor = UIColor.greenColor().CGColor
        button.layer.borderWidth = 8.0
    }

    private func removeBorderFromButton(button: UIButton) {
        button.layer.borderWidth = 0.0
    }
}
