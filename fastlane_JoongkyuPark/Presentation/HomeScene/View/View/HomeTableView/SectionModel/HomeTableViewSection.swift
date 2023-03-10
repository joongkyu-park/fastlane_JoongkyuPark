//
//  HomeTableViewSection.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/10.
//

import Foundation

import RxDataSources

enum HomeTableViewSectionItem {
    case yeoshinTVs(yeoshinTVs: [YeoshinTV])
    case yeoshinEvent(yeoshinEvent: YeoshinEvent)
}

struct HomeTableViewSection {
    let title: String
    var items: [HomeTableViewSectionItem]
    
    init(title: String, items: [HomeTableViewSectionItem]) {
        self.title = title
        self.items = items
    }
}

extension HomeTableViewSection: SectionModelType {
    typealias Item = HomeTableViewSectionItem
    
    init(original: HomeTableViewSection, items: [HomeTableViewSectionItem]) {
        self = original
        self.items = items
    }
}
