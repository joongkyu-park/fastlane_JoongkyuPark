//
//  YeoshinDTO.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

// MARK: - Data Transfer Object

struct YeoshinResponseDTO: Decodable {
    let serverCode, serverMsg: String
    let results: ResultsDTO
}

extension YeoshinResponseDTO {
    struct ResultsDTO: Decodable {
        let displayTagList: [DisplayTagListDTO]
        let bannerList: [BannerListDTO]
        let recommendEventList, newEventList: [EventListDTO]
        let ysTvList: [YsTvListDTO]
    }
}

extension YeoshinResponseDTO.ResultsDTO {
    struct BannerListDTO: Decodable {
        let bannerID, bannerType, bannerImg, bannerLink, bannerTitle, bannerListRank, bannerStartDate, bannerEndDate: String
        
        enum CodingKeys: String, CodingKey {
            case bannerID = "bannerId"
            case bannerType, bannerImg, bannerLink, bannerTitle, bannerListRank, bannerStartDate, bannerEndDate
        }
    }
}

extension YeoshinResponseDTO.ResultsDTO {
    struct DisplayTagListDTO: Decodable {
        
        let tagName, tagLink: String
        let tagRank, createAdminID, updateAdminID: Int
        let createAt, updatedAt: String
        let id: Int?
        let tagID: String?
        
        enum CodingKeys: String, CodingKey {
            case tagName, tagLink, tagRank
            case createAdminID = "createAdminId"
            case updateAdminID = "updateAdminId"
            case createAt, updatedAt, id
            case tagID = "tagId"
        }
    }
}

extension YeoshinResponseDTO.ResultsDTO {
    struct EventListDTO: Decodable {
        let name, comment, customerName, displayName: String
        let price: Int
        let currencyName: CurrencyName
        let customerCode: String
        let score: Int
        let cpmBudgetScore: Double
        let locationName, productCode: String
        let wishCount, reviewCount, rateScore, distance: Int
        let wishIcon: WishIcon
        let thumbnailImageURL, detailLinkURL: String
        let reservationYn: ReservationYn

        enum CodingKeys: String, CodingKey {
            case name, comment, customerName, displayName, price, currencyName, customerCode, score, cpmBudgetScore, locationName, productCode, wishCount, reviewCount, rateScore, distance, wishIcon
            case thumbnailImageURL = "thumbnailImageUrl"
            case detailLinkURL = "detailLinkUrl"
            case reservationYn
        }
        
        enum CurrencyName: String, Decodable {
            case 원 = "원"
        }

        enum ReservationYn: String, Decodable {
            case n = "N"
            case y = "Y"
        }

        enum WishIcon: String, Decodable {
            case off = "off"
        }
    }
}



extension YeoshinResponseDTO.ResultsDTO {
    struct YsTvListDTO: Decodable {
        let tvID, tvCode, tvNameMain, tvInputDate, tvViewCount, tvMetatagTitle, tvVideoURL, tvVideoID: String
        let tvImgType: TvImgType
        let tvVideoThumb, tvFullImgURL: String
        
        enum CodingKeys: String, CodingKey {
            case tvID = "tvId"
            case tvCode, tvNameMain, tvInputDate, tvViewCount, tvMetatagTitle
            case tvVideoURL = "tvVideoUrl"
            case tvVideoID = "tvVideoId"
            case tvImgType, tvVideoThumb
            case tvFullImgURL = "tvFullImgUrl"
        }
        
        enum TvImgType: String, Codable {
            case auto = "auto"
            case direct = "direct"
        }
    }
}

// MARK: - Mappings to Domain

extension YeoshinResponseDTO {
    func toDomain() -> YeoshinItem {
        return .init(yeoshinTVs: results.ysTvList.map { $0.toDomain() },
                     recommendYeoshinEvents: results.recommendEventList.map { $0.toDomain() },
                     newYeoshinEvents: results.newEventList.map { $0.toDomain() })
    }
}

extension YeoshinResponseDTO.ResultsDTO.EventListDTO {
    func toDomain() -> YeoshinEvent {
        return .init(name: name,
                     comment: comment,
                     customerName: customerName,
                     displayName: displayName,
                     locationName: locationName,
                     price: price(price: price, currency: currencyName.rawValue),
                     imageURL: thumbnailImageURL)
    }
    
    private func price(price: Int, currency: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let costText = numberFormatter.string(from: NSNumber(value: price)) else { return "null" }
        return costText + currency
    }
}

extension YeoshinResponseDTO.ResultsDTO.YsTvListDTO {
    func toDomain() -> YeoshinTV {
        return .init(name: tvNameMain,
                     imageURL: tvFullImgURL)
    }
}
