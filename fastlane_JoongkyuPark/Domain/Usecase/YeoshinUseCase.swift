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
    
    var yeoshinTVs = PublishSubject<[YeoshinTV]>()
    var recommendYeoshinEvents = PublishSubject<[YeoshinEvent]>()
    var newYeoshinEvents = PublishSubject<[YeoshinEvent]>()
    
    init(yeoshinRepository: YeoshinRepository) {
        self.yeoshinRepository = yeoshinRepository
    }
    
    func fetchYeoshin() {
        yeoshinRepository.fetchYeoshin()
            .subscribe(onNext: { [weak self] yeoshin in
                guard let self = self else { return }
                self.yeoshinTVs.onNext(yeoshin.yeoshinTVs)
                self.recommendYeoshinEvents.onNext(yeoshin.recommendYeoshinEvents)
                self.newYeoshinEvents.onNext(yeoshin.newYeoshinEvents)
            })
            .disposed(by: self.disposeBag)
    }
}
