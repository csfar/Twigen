//
//  TweetsViewController.swift
//  Twigen
//
//  Created by Artur Carneiro on 17/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import UIKit
import Foundation

final class TweetsViewController: UIViewController {
    @AutoLayout private var tableView: UITableView

    private let controller: TweetsController

    init(controller: TweetsController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        controller.fetch()
        tableView.separatorStyle = .none
    }

    private func setupUI() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate(
            [tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
             tableView.widthAnchor.constraint(equalTo: view.widthAnchor)]
        )
    }

    func refresh() {
        controller.fetch()
    }
}

extension TweetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = controller.contentAt(index: indexPath.row)
        let likes = controller.likesAt(index: indexPath.row)
        let cell = TweetsTableViewCell()
        cell.setupCell(content: content, with: likes)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.numberOfRows
    }
}

extension TweetsViewController: UITableViewDelegate {

}

extension TweetsViewController: TweetsControllerDelegate {
    func updateUI() {
        tableView.reloadData()
    }

}
