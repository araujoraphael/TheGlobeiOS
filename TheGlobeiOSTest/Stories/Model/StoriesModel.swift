//
//  StoriesModel.swift
//  TheGlobeiOSTest
//
//  Created by Raphael Araújo on 2024-10-15.
//

struct PromoImage: Codable {
    let urls: [String: String]?
}

struct Story: Codable {
    let headline: String
    let protectionProduct: String?
    let bylines: [String]?
    let promoImage: PromoImage?
    
    enum CodingKeys: String, CodingKey {
        case headline = "title"
        case protectionProduct = "protection_product"
        case bylines = "byline"
        case promoImage = "promo_image"
    }
}

struct StoriesModel: Codable {
    let stories: [Story]
    
    enum CodingKeys: String, CodingKey {
        case stories = "recommendations"
    }
}
