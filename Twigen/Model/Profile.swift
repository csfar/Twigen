//
//  Profile.swift
//  Twigen
//
//  Created by Artur Carneiro on 16/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

public struct Profile {
    var name: String?
    var image: Data?
    var handle: String?
    var bio: String?
    var joinedDate: Date?
    var followers: Int?
    var following: Int?
}
