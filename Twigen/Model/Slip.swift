//
//  Slip.swift
//  Twigen
//
//  Created by Artur Carneiro on 16/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation

struct Slip: Decodable {
    let advice: String
    let id: String

    private enum CodingKeys: String, CodingKey {
        case advice
        case id = "slip_id"
    }
}

struct SlipResponse: Decodable {
    let slip: Slip
}
