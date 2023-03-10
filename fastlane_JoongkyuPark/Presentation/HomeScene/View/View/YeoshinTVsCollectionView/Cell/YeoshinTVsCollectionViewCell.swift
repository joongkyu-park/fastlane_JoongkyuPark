//
//  YeoshinTVsCollectionViewCell.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import UIKit

final class YeoshinTVsCollectionViewCell: UICollectionViewCell {
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: .init(width: 150, height: 85)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = UIColor(red: 230.0 / 255.0, green: 230.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
        imageView.image = Image.noImage
        imageView.contentMode = .scaleAspectFit
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = Image.noImage
    }
    
    private func setUpUI() {
        setUpCell()
        setUpThumbnailImageView()
        setUpTitleLabel()
    }
    
    func updateContent(with entity: YeoshinTV) {
        thumbnailImageView.setImage(with: entity.imageURL)
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
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 150),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 85)
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
