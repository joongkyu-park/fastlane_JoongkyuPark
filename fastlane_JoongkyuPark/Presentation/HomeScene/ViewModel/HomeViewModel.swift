//
//  HomeViewModel.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import Foundation

import RxCocoa
import RxSwift

final class HomeViewModel {
    private let yeoshinUseCase: YeoshinUseCase
    private let disposeBag = DisposeBag()
    
    init(yeoshinUseCase: YeoshinUseCase) {
        self.yeoshinUseCase = yeoshinUseCase
    }
}

extension HomeViewModel {
    struct Input {
        let viewDidLoadEvent: Observable<Void>
        let didSelectItem: Observable<Int>
    }
    
    struct Output {
        var yeoshinTVs = BehaviorRelay<[YeoshinTV]>(value: [])
        var recommendYeoshinEvents = BehaviorRelay<[YeoshinEvent]>(value: [])
        var newYeoshinEvents = BehaviorRelay<[YeoshinEvent]>(value: [])
    }
}

extension HomeViewModel {
    func transform(from input: Input) -> Output {
        self.configureInput(input)
        return createOutput()
    }
    
    private func configureInput(_ input: Input) {
        input.viewDidLoadEvent
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.yeoshinUseCase.fetchYeoshin()
            })
            .disposed(by: disposeBag)
    }
    
    private func createOutput() -> Output {
        let output = Output()
        
        self.yeoshinUseCase.yeoshinTVs
            .bind(to: output.yeoshinTVs)
            .disposed(by: disposeBag)
        
        self.yeoshinUseCase.recommendYeoshinEvents
            .bind(to: output.recommendYeoshinEvents)
            .disposed(by: disposeBag)
        
        self.yeoshinUseCase.newYeoshinEvents
            .bind(to: output.newYeoshinEvents)
            .disposed(by: disposeBag)
        
        return output
    }
}
