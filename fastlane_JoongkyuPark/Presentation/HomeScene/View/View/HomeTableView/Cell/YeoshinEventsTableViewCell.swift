//
//  YeoshinEventsTableViewCell.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import UIKit

final class YeoshinEventsTableViewCell: UITableViewCell {
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: .init(width: 90, height: 90)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .clear
        imageView.image = Image.noImage
        return imageView
    }()
    private let textContainerStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(249), for: .vertical)
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemPink
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = Image.noImage
    }
    
    private func setUpUI() {
        setUpCell()
        setUpThumbnailImageView()
        setUpTextContainerStackView()
    }

    func updateContent(with entity: YeoshinEvent) {
        thumbnailImageView.setImage(with: entity.imageURL)
        nameLabel.text = entity.displayName
        titleLabel.text = entity.name
        commentLabel.text = entity.comment
        priceLabel.text = entity.price
    }
}

// MARK: - Cell
extension YeoshinEventsTableViewCell {
    private func setUpCell() {
        [thumbnailImageView, textContainerStackView].forEach { self.addSubview($0) }
        self.backgroundColor = .white
        self.selectionStyle = .none
    }
}

// MARK: - Thumbnail ImageView

extension YeoshinEventsTableViewCell {
    private func setUpThumbnailImageView() {
        setConstraintsOfThumbnailImageView()
    }
    
    private func setConstraintsOfThumbnailImageView() {
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            thumbnailImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 90),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}

// MARK: - Text Container StackView

extension YeoshinEventsTableViewCell {
    private func setUpTextContainerStackView() {
        [nameLabel, titleLabel, commentLabel, priceLabel].forEach { textContainerStackView.addArrangedSubview($0) }
        setConstraintsOfTextContainerStackView()
    }
    
    private func setConstraintsOfTextContainerStackView() {
        NSLayoutConstraint.activate([
            textContainerStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            textContainerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            textContainerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            textContainerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
