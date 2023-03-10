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
    weak var coordinator: HomeCoordinator?
    private let yeoshinUseCase: YeoshinUseCase
    private var sections: [HomeTableViewSection] = []
    
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
        
        input.cellDidSelectEvent
            .subscribe({ [weak self] controlEvent in
                guard let controlEvent = controlEvent.element else { return }
                let (section, row) = (controlEvent.0, controlEvent.1)
                guard section != 0 else { return }
                guard let yeoshinEvent = self?.yeoshinEvent(section: section, row: row) else { return }
                self?.coordinator?.pushEventDetailViewController(with: yeoshinEvent)
            })
            .disposed(by: disposeBag)
    }
    
    private func createOutput(disposeBag: DisposeBag) -> Output {
        let output = Output()
    
        self.yeoshinUseCase.sections
            .do(onNext: { self.sections = $0 })
            .bind(to: output.sections)
            .disposed(by: disposeBag)
        
        return output
    }
    
    private func yeoshinEvent(section: Int, row: Int) -> YeoshinEvent? {
        let sectionModel = sections[safe: section]
        let yeoshinEvent = sectionModel?.items[safe: row]
        switch yeoshinEvent {
        case .yeoshinEvent(let yeoshinEvent):
            return yeoshinEvent
        default:
            return nil
        }
    }
}
