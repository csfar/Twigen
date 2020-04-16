//
//  Endpoints.swift
//  Twigen
//
//  Created by Artur Carneiro on 16/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

enum Endpoints {
    case robot
    case genre
    case slip
}

extension Endpoints {
    var url: URL {
        switch self {
        case .genre:
            return URL(string: "https://binaryjazz.us/wp-json/genrenator/v1/genre/")!
        case .slip:
            return URL(string: "https://api.adviceslip.com/advice")!
        case .robot:
            let uuid: String = UUID().uuidString
            return URL(string: "https://robohash.org/\(uuid)")!
        }
    }
}
