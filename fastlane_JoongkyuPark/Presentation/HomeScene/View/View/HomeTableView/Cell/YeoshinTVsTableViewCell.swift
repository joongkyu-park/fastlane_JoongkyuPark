//
//  YeoshinTVsTableViewCell.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/10.
//

import UIKit

import RxCocoa
import RxSwift

final class YeoshinTVsTableViewCell: UITableViewCell {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100.0, height: 80.0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    private let viewModel = YeoshinTVsCollectionViewModel()
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        setUpCell()
        setUpCollectionView()
    }
}

// MARK: - Cell

extension YeoshinTVsTableViewCell {
    private func setUpCell() {
        self.addSubview(collectionView)
        self.backgroundColor = .white
        self.selectionStyle = .none
    }
}

// MARK: - CollectionView

extension YeoshinTVsTableViewCell {
    private func setUpCollectionView() {
        collectionView.register(YeoshinTVsCollectionViewCell.self, forCellWithReuseIdentifier: YeoshinTVsCollectionViewCell.identifier)
        setConstraintsOfCollectionView()
    }
    
    private func setConstraintsOfCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func bindViewModel(with entities: [YeoshinTV]) {
        let input = YeoshinTVsCollectionViewModel.Input(
            reusingTableViewCellEvent: Observable.of(entities)
        )
        let output = viewModel.transform(from: input, disposeBag: disposeBag)

        bindCollectionView(output: output, disposeBag: disposeBag)
    }
    
    private func bindCollectionView(output: YeoshinTVsCollectionViewModel.Output?, disposeBag: DisposeBag) {
        output?.yeoshinTVs
            .asDriver(onErrorJustReturn: [])
            .drive(
                    collectionView.rx.items(
                    cellIdentifier: YeoshinTVsCollectionViewCell.identifier,
                    cellType: YeoshinTVsCollectionViewCell.self
                )
            ) { _, yeoshinTV, cell in
                cell.updateContent(with: yeoshinTV)
            }
            .disposed(by: disposeBag)
    }

}
