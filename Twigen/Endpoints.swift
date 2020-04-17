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
    case name
    case bacon
    case asdfast
    case hipster
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
        case .name:
            return URL(string: "https://randomuser.me/api/?inc=name")!
        case .bacon:
            return URL(string: "https://baconipsum.com/api/?type=meat-and-filler&sentences=3")!
        case .asdfast:
            return URL(string: "http://asdfast.beobit.net/api/?length=30&type=word")!
        case .hipster:
            return URL(string: "https://hipsum.co/api/?type=hipster-centric&sentences=2")!
        }
    }
}
