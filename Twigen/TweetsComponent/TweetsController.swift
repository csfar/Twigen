//
//  TweetsController.swift
//  Twigen
//
//  Created by Artur Carneiro on 17/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

protocol TweetsControllerDelegate: AnyObject {
    func updateUI()
}

final class TweetsController {
    private let generator: TweetsGenerator
    private var tweets: [Tweet] = [Tweet]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.updateUI()
            }
        }
    }

    weak var delegate: TweetsControllerDelegate?

    init(generator: TweetsGenerator) {
        self.generator = generator
    }

    func fetch() {
        generator.generate { [weak self] (result) in
            switch result {
            case .success(let tweets):
                self?.tweets = tweets
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    var numberOfRows: Int {
        return tweets.count
    }

    func contentAt(index: Int) -> String {
        return tweets[index].content
    }

    func likesAt(index: Int) -> Int {
        return tweets[index].likes
    }
}
