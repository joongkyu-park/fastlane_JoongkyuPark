//
//  YeoshinEventsTableViewCell.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/09.
//

import UIKit

final class YeoshinEventsTableViewCell: UITableViewCell {
    private let containerStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        return stackView
    }()
    private let textContainerStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        return stackView
    }()
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: .init(width: 70.0, height: 70.0)))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .systemPink
        label.numberOfLines = 1
        return label
    }()
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        setUpCell()
        setUpContainerStackView()
        setUpTextContainerStackView()
    }

    func updateContent(with entity: YeoshinEvent) {
        nameLabel.text = entity.displayName
        titleLabel.text = entity.name
        commentLabel.text = entity.comment
    }
}

// MARK: - Cell
extension YeoshinEventsTableViewCell {
    private func setUpCell() {
        self.addSubview(containerStackView)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
    }
}

// MARK: - Container StackView

extension YeoshinEventsTableViewCell {
    private func setUpContainerStackView() {
        [thumbnailImageView, textContainerStackView].forEach { containerStackView.addArrangedSubview($0) }
        setConstraintsOfContainerStackView()
    }
    
    private func setConstraintsOfContainerStackView() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Text Container StackView

extension YeoshinEventsTableViewCell {
    private func setUpTextContainerStackView() {
        [nameLabel, titleLabel, commentLabel, priceLabel].forEach { containerStackView.addArrangedSubview($0) }
    }
}
