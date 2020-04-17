//
//  ProfileViewController.swift
//  Twigen
//
//  Created by Artur Carneiro on 16/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import UIKit

@propertyWrapper class AutoLayout<View: UIView> {
    private lazy var view: View = {
        let view = View(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var wrappedValue: View {
        return view
    }
}

final class ProfileViewController: UIViewController {

    @AutoLayout private var photo: UIImageView
    @AutoLayout private var nameLabel: UILabel
    @AutoLayout private var handleLabel: UILabel
    @AutoLayout private var bioLabel: UILabel
    @AutoLayout private var joinedDateLabel: UILabel
    @AutoLayout private var followersLabel: UILabel
    @AutoLayout private var followingLabel: UILabel
    @AutoLayout private var followStack: UIStackView

    private let controller: ProfileController

    init(controller: ProfileController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller.delegate = self
        setupUI()
        controller.fetch()
    }

    private func setupUI() {
        photo.layer.cornerRadius = 50
        photo.clipsToBounds = true
        photo.backgroundColor = .systemGray6

        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        handleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        handleLabel.textColor = .systemGray

        bioLabel.font = UIFont.preferredFont(forTextStyle: .body)
        bioLabel.lineBreakMode = .byWordWrapping
        bioLabel.numberOfLines = 0

        joinedDateLabel.font = UIFont.preferredFont(forTextStyle: .footnote)

        followStack.axis = .horizontal
        followStack.spacing = 5

        followStack.addArrangedSubview(followingLabel)
        followStack.addArrangedSubview(followersLabel)

        view.addSubview(photo)
        view.addSubview(nameLabel)
        view.addSubview(handleLabel)
        view.addSubview(bioLabel)
        view.addSubview(joinedDateLabel)
        view.addSubview(followStack)

        NSLayoutConstraint.activate(
            [photo.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
             photo.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 0),
             photo.widthAnchor.constraint(equalToConstant: 100),
             photo.heightAnchor.constraint(equalToConstant: 100)]
        )

        NSLayoutConstraint.activate(
            [nameLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 15),
             nameLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
             nameLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor)]
        )

        NSLayoutConstraint.activate(
            [handleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
             handleLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
             handleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor)]
        )

        NSLayoutConstraint.activate(
            [bioLabel.topAnchor.constraint(equalTo: handleLabel.bottomAnchor, constant: 15),
             bioLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
             bioLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor)]
        )

        NSLayoutConstraint.activate(
            [joinedDateLabel.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 15),
             joinedDateLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
             joinedDateLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor)]
        )

        NSLayoutConstraint.activate(
            [followStack.topAnchor.constraint(equalTo: joinedDateLabel.bottomAnchor, constant: 15),
             followStack.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
             followStack.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5)]
        )

    }

    private func boldRegularStyle(bold: String, regular: String) -> NSMutableAttributedString {
        let boldText = NSAttributedString(string: "\(bold) ",
                                          attributes: [NSAttributedString.Key.font:
                                            UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize)] )
        let regularText = NSAttributedString(string: regular,
                                             attributes: [NSAttributedString.Key.font:
                                                UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)])
        let mutableString = NSMutableAttributedString()
        mutableString.append(boldText)
        mutableString.append(regularText)
        return mutableString
    }

    func refresh() {
        controller.fetch()
    }

}

extension ProfileViewController: ProfileControllerDelegate {
    func updateUI() {
        nameLabel.text = controller.name
        handleLabel.text = controller.handle
        photo.image = UIImage(data: controller.image)
        bioLabel.text = controller.bio
        joinedDateLabel.text = controller.joinedDate
        followingLabel.attributedText = boldRegularStyle(bold: "\(controller.following)", regular: "Following")
        followersLabel.attributedText = boldRegularStyle(bold: "\(controller.followers)", regular: "Followers")
    }
}
