//
//  ProfileController.swift
//  Twigen
//
//  Created by Artur Carneiro on 16/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

protocol ProfileControllerDelegate: AnyObject {
    func updateUI()
}

final class ProfileController {
    private let generator: ProfileGenerator
    private var profile: Profile = Profile() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.updateUI()
            }
        }
    }

    weak var delegate: ProfileControllerDelegate?

    init(generator: ProfileGenerator) {
        self.generator = generator
    }

    func fetch() {
        generator.generate { [weak self] (result) in
            switch result {
            case .success(let profile):
                self?.profile = profile
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    var name: String {
        return profile.name?.capitalized ?? ""
    }

    var handle: String {
        let trimmedHandle = profile.handle?.trimmingCharacters(in: .whitespaces) ?? ""
        let capitalized = trimmedHandle.capitalized
        let removedSpaces = capitalized.replacingOccurrences(of: " ", with: "")
        return ("@\(removedSpaces)")
    }

    var bio: String {
        return profile.bio ?? ""
    }

    var joinedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM y"
        return "Joined on \(formatter.string(from: profile.joinedDate ?? Date()))"
    }

    var image: Data {
        return profile.image ?? Data()
    }

    var followers: Int {
        return profile.followers ?? 0
    }

    var following: Int {
        return profile.following ?? 0
    }

}
