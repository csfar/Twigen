//
//  Tweet.swift
//  Twigen
//
//  Created by Artur Carneiro on 16/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

struct Tweet {
    let author: Profile
    let content: String
    let creationDate: Date
    let likes: Int
}
