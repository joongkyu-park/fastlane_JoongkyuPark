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
    
    init(yeoshinUseCase: YeoshinUseCase) {
        self.yeoshinUseCase = yeoshinUseCase
    }
}

extension HomeViewModel {
    struct Input {
        let viewDidLoadEvent: Observable<Void>
        let cellDidSelectEvent: Observable<(Int, Int)>
    }
    
    struct Output {
        var sections = BehaviorRelay<[HomeTableViewSection]>(value: [])
    }
}

extension HomeViewModel {
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        self.configureInput(input, disposeBag: disposeBag)
        return createOutput(disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input, disposeBag: DisposeBag) {
        input.viewDidLoadEvent
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.yeoshinUseCase.fetchYeoshin()
            })
            .disposed(by: disposeBag)
    }
    
    private func createOutput(disposeBag: DisposeBag) -> Output {
        let output = Output()
    
        self.yeoshinUseCase.sections
            .bind(to: output.sections)
            .disposed(by: disposeBag)
        
        return output
    }
}
