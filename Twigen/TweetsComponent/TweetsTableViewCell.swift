//
//  TweetsTableViewCell.swift
//  Twigen
//
//  Created by Artur Carneiro on 17/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import UIKit

final class TweetsTableViewCell: UITableViewCell {

    @AutoLayout private var contentLabel: UILabel
    @AutoLayout private var likesLabel: UILabel

    func setupCell(content: String, with likes: Int ) {
        contentLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.text = content

        likesLabel.font = UIFont.preferredFont(forTextStyle: .body)
        likesLabel.text = "\(likes) likes"

        contentView.addSubview(contentLabel)
        contentView.addSubview(likesLabel)

        NSLayoutConstraint.activate(
            [contentLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
             contentLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
             contentLabel.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor),
             contentLabel.heightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.heightAnchor, multiplier: 0.8)]
        )

        NSLayoutConstraint.activate(
            [likesLabel.topAnchor.constraint(equalTo: contentLabel.layoutMarginsGuide.bottomAnchor, constant: 10),
             likesLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
             likesLabel.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor),
             likesLabel.heightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.heightAnchor, multiplier: 0.15)]
        )

    }
}
