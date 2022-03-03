//
//  MarketModel.swift
//  BraveNewCoinApp
//
//  Created by Sinan Kulen on 3.03.2022.
//

import Foundation
struct MarketModel: Codable {
    let content: [MarketContent]
}

// MARK: - Content
struct MarketContent: Codable {
    let id, baseAssetID, quoteAssetID: String

    enum CodingKeys: String, CodingKey {
        case id
        case baseAssetID = "baseAssetId"
        case quoteAssetID = "quoteAssetId"
    }
}
