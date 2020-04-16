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

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let url = Endpoints.robot.url

        do {
            let data = try Data(contentsOf: url)
            photo.image = UIImage(data: data)
        } catch {
            print(error)
        }
        
        setupUI()
    }

    private func setupUI() {
        photo.layer.cornerRadius = 50
        photo.clipsToBounds = true
        photo.backgroundColor = .systemGray6

        view.addSubview(photo)

        NSLayoutConstraint.activate(
            [photo.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
             photo.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 0),
             photo.widthAnchor.constraint(equalToConstant: 100),
             photo.heightAnchor.constraint(equalToConstant: 100)]
        )
    }

}
