//
//  TokenModel.swift
//  BraveNewCoinApp
//
//  Created by Sinan Kulen on 2.03.2022.
//

import Foundation

struct TokenModel: Codable {
    let accessToken, scope: String
    let expiresIn: Int
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case scope
        case expiresIn = "expires_in"
        case tokenType = "token_type"
    }
}
