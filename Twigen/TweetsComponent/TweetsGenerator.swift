//
//  TweetsGenerator.swift
//  Twigen
//
//  Created by Artur Carneiro on 17/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

final class TweetsGenerator {

    init() {

    }

    public func generate(completionHandler: @escaping (Result<[Tweet], Error>) -> Void) {
        let group = DispatchGroup()
        var tweets: [Tweet] = [Tweet]()

        group.enter()
        loadBacon(from: Endpoints.bacon.url) { (result) in
            switch result {
            case .success(let ipsumArr):
                if let ipsum = ipsumArr.first {
                    let tweet = Tweet(content: ipsum, likes: ipsum.count)
                    tweets.append(tweet)
                    group.leave()
                } else {
                    group.leave()
                }
            case .failure(let error):
                print(error)
                group.leave()
            }
        }

        group.enter()
        loadHipster(from: Endpoints.hipster.url) { (result) in
            switch result {
            case .success(let ipsumArr):
                if let ipsum = ipsumArr.first {
                    let tweet = Tweet(content: ipsum, likes: ipsum.count)
                    tweets.append(tweet)
                    group.leave()
                } else {
                    group.leave()
                }
            case .failure(let error):
                print(error)
                group.leave()
            }
        }

//        group.enter()
//        loadAsdfast(from: Endpoints.asdfast.url) { (result) in
//            switch result {
//            case .success(let asdfast):
//                let tweet = Tweet(content: asdfast.text, likes: asdfast.text.count)
//                tweets.append(tweet)
//                group.leave()
//            case .failure(let error):
//                print(error)
//                group.leave()
//            }
//        }

        group.notify(queue: .global(qos: .userInitiated)) {
            completionHandler(.success(tweets))
        }
    }

    private func loadBacon(from url: URL, completionHandler: @escaping (Result<[String], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let ipsum = try JSONDecoder().decode([String].self, from: data)
                    completionHandler(.success(ipsum))
                } catch let throwError {
                    completionHandler(.failure(throwError))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }

    private func loadHipster(from url: URL, completionHandler: @escaping (Result<[String], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let ipsum = try JSONDecoder().decode([String].self, from: data)
                    completionHandler(.success(ipsum))
                } catch let throwError {
                    completionHandler(.failure(throwError))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }

    private func loadAsdfast(from url: URL, completionHandler: @escaping (Result<Asdfast, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let ipsum = try JSONDecoder().decode(Asdfast.self, from: data)
                    completionHandler(.success(ipsum))
                } catch let throwError {
                    completionHandler(.failure(throwError))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
}
