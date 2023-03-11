//
//  HomeSection.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/10.
//

import Foundation

import RxDataSources

enum HomeSectionItem {
    case yeoshinTVs(yeoshinTVs: [YeoshinTV])
    case yeoshinEvent(yeoshinEvent: YeoshinEvent)
}

struct HomeSection {
    let title: String
    var items: [HomeSectionItem]
    
    init(title: String, items: [HomeSectionItem]) {
        self.title = title
        self.items = items
    }
}

extension HomeSection: SectionModelType {
    typealias Item = HomeSectionItem
    
    init(original: HomeSection, items: [HomeSectionItem]) {
        self = original
        self.items = items
    }
}
