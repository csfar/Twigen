//
//  ParentViewController.swift
//  Twigen
//
//  Created by Artur Carneiro on 17/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import UIKit

final class ParentViewController: UIViewController {

    private let profileViewController: ProfileViewController
    private let tweetsViewController: TweetsViewController

    init() {
        let profileGenerator = ProfileGenerator()
        let profileController = ProfileController(generator: profileGenerator)
        self.profileViewController = ProfileViewController(controller: profileController)

        let tweetsGenerator = TweetsGenerator()
        let tweetsController = TweetsController(generator: tweetsGenerator)
        self.tweetsViewController = TweetsViewController(controller: tweetsController)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self,
                                                            action: #selector(refresh))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info"), style: .plain,
                                                           target: self, action: #selector(showInfo))

        view.addSubview(profileViewController.view)
        self.addChild(profileViewController)
        profileViewController.didMove(toParent: self)
        profileViewController.view.translatesAutoresizingMaskIntoConstraints = false
        profileViewController.view.clipsToBounds = true

        view.addSubview(tweetsViewController.view)
        self.addChild(tweetsViewController)
        tweetsViewController.didMove(toParent: self)
        tweetsViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileViewController.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            profileViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileViewController.view.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor,
                                                               multiplier: 0.4)
        ])

        NSLayoutConstraint.activate([
            tweetsViewController.view.topAnchor.constraint(equalTo: profileViewController.view.bottomAnchor),
            tweetsViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tweetsViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            tweetsViewController.view.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor,
                                                              multiplier: 0.6)
        ])
    }

    @objc private func refresh() {
        tweetsViewController.refresh()
        profileViewController.refresh()
    }

    @objc private func showInfo() {
        let infoViewController = InfoViewController()
        navigationController?.present(infoViewController, animated: true, completion: nil)
    }
}
