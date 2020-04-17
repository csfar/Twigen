//
//  ProfileGenerator.swift
//  Twigen
//
//  Created by Artur Carneiro on 16/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

public final class ProfileGenerator {

    init() {

    }

    public func generate(completionHandler: @escaping (Result<Profile, Error>) -> Void) {
        let group = DispatchGroup()
        var profile = Profile()
        profile.joinedDate = Date()

        group.enter()
        loadRobot(from: Endpoints.robot.url) { (result) in
            switch result {
            case .success(let data):
                profile.image = data
                group.leave()
            case .failure(let error):
                print(error)
                group.leave()
            }
        }

        group.enter()
        loadMusicGenre(from: Endpoints.genre.url) { (result) in
            switch result {
            case .success(let genre):
                profile.handle = genre
                group.leave()
            case .failure(let error):
                print(error)
                group.leave()
            }
        }

        group.enter()
        loadAdvice(from: Endpoints.slip.url) { (result) in
            switch result {
            case .success(let slip):
                profile.followers = Int(slip.id) ?? 0 + 2
                profile.following = Int(slip.id)
                profile.bio = slip.advice
                group.leave()
            case .failure(let error):
                print(error)
                group.leave()
            }
        }

        group.enter()
        loadName(from: Endpoints.name.url) { (result) in
            switch result {
            case .success(let nameArr):
                if let firstName = nameArr.first?.name.first, let lastName = nameArr.first?.name.last {
                    profile.name = "\(firstName) \(lastName)"
                    group.leave()
                } else {
                    profile.name = "Ixi não foi"
                    group.leave()
                }
            case .failure(let error):
                print(error)
                group.leave()
            }
        }
        
        group.notify(queue: .global(qos: .userInitiated)) {
            completionHandler(.success(profile))
        }

    }

    private func loadRobot(from url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completionHandler(.success(data))
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }

    private func loadMusicGenre(from url: URL, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let genre = try JSONDecoder().decode(String.self, from: data)
                    completionHandler(.success(genre))
                } catch let throwError {
                    completionHandler(.failure(throwError))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }

    private func loadAdvice(from url: URL, completionHandler: @escaping (Result<Slip, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(SlipResponse.self, from: data)
                    completionHandler(.success(res.slip))
                } catch let throwError {
                    completionHandler(.failure(throwError))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }

    private func loadName(from url: URL, completionHandler: @escaping (Result<[NameResponse], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(NameFullResponse.self, from: data)
                    completionHandler(.success(res.results))
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
