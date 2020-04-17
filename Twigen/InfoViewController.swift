//
//  InfoViewController.swift
//  Twigen
//
//  Created by Artur Carneiro on 17/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import UIKit

final class InfoViewController: UIViewController {

    @AutoLayout private var stack: UIStackView
    @AutoLayout private var roboAPI: UILabel
    @AutoLayout private var adviceAPI: UILabel
    @AutoLayout private var genreAPI: UILabel
    @AutoLayout private var randomUserAPI: UILabel
    @AutoLayout private var baconIpsumAPI: UILabel
    @AutoLayout private var hispterIpsumAPI: UILabel

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        roboAPI.text = "Robots lovingly delivered by Robohash.org"
        adviceAPI.text = "AdviceSlip.com • © Tom Kiss 2020 API"
        genreAPI.text = "Binary Jazz genrenator API"
        randomUserAPI.text = "randomuser.me API"
        baconIpsumAPI.text = "Bacon Ipsum API"
        hispterIpsumAPI.text = "Hipsum API"

        stack.axis = .vertical
        stack.distribution = .fillEqually

        stack.addArrangedSubview(roboAPI)
        stack.addArrangedSubview(adviceAPI)
        stack.addArrangedSubview(genreAPI)
        stack.addArrangedSubview(randomUserAPI)
        stack.addArrangedSubview(baconIpsumAPI)
        stack.addArrangedSubview(hispterIpsumAPI)

        view.addSubview(stack)

        NSLayoutConstraint.activate(
            [stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             stack.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
             stack.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)]
        )
    }
}
