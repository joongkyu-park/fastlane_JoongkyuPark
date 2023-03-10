//
//  YeoshinUseCase.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

import RxSwift

final class YeoshinUseCase {
    private let yeoshinRepository: YeoshinRepository
    private let disposeBag = DisposeBag()
    
    var sections = PublishSubject<[HomeTableViewSection]>()
    
    init(yeoshinRepository: YeoshinRepository) {
        self.yeoshinRepository = yeoshinRepository
    }
    
    func fetchYeoshin() {
        yeoshinRepository.fetchYeoshin()
            .subscribe(onNext: { [weak self] yeoshin in
                guard let self = self else { return }
                let yeoshinTVs = yeoshin.yeoshinTVs
                let recommendYeoshinEvents = yeoshin.recommendYeoshinEvents
                let newYeoshinEvents = yeoshin.newYeoshinEvents
                var sections = [HomeTableViewSection]()
                sections.append(HomeTableViewSection(title: "여신 TV 영상",
                                        items: [HomeTableViewSectionItem.yeoshinTVs(yeoshinTVs: yeoshinTVs)]))
                sections.append(HomeTableViewSection(title: "추천 이벤트",
                                        items: recommendYeoshinEvents.map { HomeTableViewSectionItem.yeoshinEvent(yeoshinEvent: $0) }))
                sections.append(HomeTableViewSection(title: "신규 이벤트",
                                        items: newYeoshinEvents.map { HomeTableViewSectionItem.yeoshinEvent(yeoshinEvent: $0) }))
                self.sections.onNext(sections)
            })
            .disposed(by: self.disposeBag)
    }
}
