//
//  Name.swift
//  Twigen
//
//  Created by Artur Carneiro on 17/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

struct NameFullResponse: Decodable {
    let results: [NameResponse]
}

struct NameResponse: Decodable {
    let name: Name
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}
