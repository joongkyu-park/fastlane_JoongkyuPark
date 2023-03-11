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
    
    var sections = PublishSubject<[HomeSection]>()
    
    init(yeoshinRepository: YeoshinRepository) {
        self.yeoshinRepository = yeoshinRepository
    }
    
    func fetchYeoshinItem() {
        yeoshinRepository.fetchYeoshinItem()
            .subscribe(onNext: { [weak self] yeoshin in
                guard let self = self else { return }
                let yeoshinTVs = yeoshin.yeoshinTVs
                let recommendYeoshinEvents = yeoshin.recommendYeoshinEvents
                let newYeoshinEvents = yeoshin.newYeoshinEvents
                var sections = [HomeSection]()
                sections.append(HomeSection(title: "여신 TV 영상",
                                        items: [HomeSectionItem.yeoshinTVs(yeoshinTVs: yeoshinTVs)]))
                sections.append(HomeSection(title: "추천 이벤트",
                                        items: recommendYeoshinEvents.map { HomeSectionItem.yeoshinEvent(yeoshinEvent: $0) }))
                sections.append(HomeSection(title: "신규 이벤트",
                                        items: newYeoshinEvents.map { HomeSectionItem.yeoshinEvent(yeoshinEvent: $0) }))
                self.sections.onNext(sections)
            })
            .disposed(by: self.disposeBag)
    }
}
