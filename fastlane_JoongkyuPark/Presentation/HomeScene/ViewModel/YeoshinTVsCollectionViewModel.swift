//
//  YeoshinTVsCollectionViewModel.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/10.
//

import UIKit

import RxCocoa
import RxSwift

final class YeoshinTVsCollectionViewModel {
    private var isBinded: Bool = false
}

extension YeoshinTVsCollectionViewModel {
    struct Input {
        let reusingTableViewCellEvent: Observable<[YeoshinTV]>
    }
    
    struct Output {
        var yeoshinTVs = BehaviorRelay<[YeoshinTV]>(value: [])
    }
}

extension YeoshinTVsCollectionViewModel {
    func transform(from input: Input, disposeBag: DisposeBag) -> Output? {
        guard isBinded == false else { return nil }
        self.isBinded = true
        return createOutput(input: input, disposeBag: disposeBag)
    }
    
    private func createOutput(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
    
        input.reusingTableViewCellEvent
            .bind(to: output.yeoshinTVs)
            .disposed(by: disposeBag)
        
        return output
    }
}
