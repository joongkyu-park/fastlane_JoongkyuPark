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
        var imageURL = BehaviorRelay<String>(value: "")
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
                output.imageURL.accept(yeoshinEvent.imageURL)
                output.name.accept(yeoshinEvent.customerName)
                output.location.accept(yeoshinEvent.locationName)
                output.title.accept(yeoshinEvent.name)
                output.comment.accept(yeoshinEvent.comment)
                output.price.accept(yeoshinEvent.price)
            })
            .disposed(by: disposeBag)
        
        return output
    }
}
