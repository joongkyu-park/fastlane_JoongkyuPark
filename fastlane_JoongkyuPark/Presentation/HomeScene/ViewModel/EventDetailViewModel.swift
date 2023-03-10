//
//  EventDetailViewModel.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/11.
//

import Foundation

import RxCocoa
import RxSwift

final class EventDetailViewModel {
    weak var coordinator: EventDetailCoordinator?
    private let yeoshinEvent: YeoshinEvent

    init(yeoshinEvent: YeoshinEvent) {
        self.yeoshinEvent = yeoshinEvent
    }
}

extension EventDetailViewModel {
    struct Input {
        let viewDidLoadEvent: Observable<Void>
    }
    
    struct Output {
        var name = BehaviorRelay<String>(value: "")
        var location = BehaviorRelay<String>(value: "")
        var title = BehaviorRelay<String>(value: "")
        var comment = BehaviorRelay<String>(value: "")
        var price = BehaviorRelay<String>(value: "")
    }
}

extension EventDetailViewModel {
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        return createOutput(disposeBag: disposeBag)
    }
    
    private func createOutput(disposeBag: DisposeBag) -> Output {
        let output = Output()
    
        Observable.just(yeoshinEvent)
            .bind(onNext: { yeoshinEvent in
                output.name.accept(yeoshinEvent.customerName)
                output.location.accept(yeoshinEvent.locationName)
                output.title.accept(yeoshinEvent.name)
                output.comment.accept(yeoshinEvent.comment)
                output.price.accept(String(yeoshinEvent.price) + yeoshinEvent.currecny)
            })
            .disposed(by: disposeBag)
        
        return output
    }
}
