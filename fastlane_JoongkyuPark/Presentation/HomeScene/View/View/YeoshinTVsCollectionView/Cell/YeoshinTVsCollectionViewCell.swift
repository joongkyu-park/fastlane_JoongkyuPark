//
//  YeoshinTVsCollectionViewCell.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import UIKit

final class YeoshinTVsCollectionViewCell: UICollectionViewCell {
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: .init(width: 100.0, height: 56.25)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .red
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        setUpCell()
        setUpThumbnailImageView()
        setUpTitleLabel()
    }
    
    func updateContent(with entity: YeoshinTV) {
        titleLabel.text = entity.name 
    }
}

// MARK: - Cell
extension YeoshinTVsCollectionViewCell {
    private func setUpCell() {
        [thumbnailImageView, titleLabel].forEach { self.addSubview($0) }
        self.backgroundColor = .white
    }
}

// MARK: - Thumbnail ImageView

extension YeoshinTVsCollectionViewCell {
    private func setUpThumbnailImageView() {
        setConstraintsOfThumbnailImageView()
    }
    
    private func setConstraintsOfThumbnailImageView() {
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 100.0),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 56.25)
        ])
    }
}

// MARK: - Title Label

extension YeoshinTVsCollectionViewCell {
    private func setUpTitleLabel() {
        setConstraintsOfTitleLabel()
    }
    
    private func setConstraintsOfTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
