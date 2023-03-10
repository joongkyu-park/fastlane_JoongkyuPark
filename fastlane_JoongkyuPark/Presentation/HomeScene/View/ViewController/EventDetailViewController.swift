//
//  EventDetailViewController.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/11.
//

import UIKit

import RxCocoa
import RxSwift

final class EventDetailViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .top
        return stackView
    }()
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    
    var viewModel: EventDetailViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bindViewModel()
    }
    
    private func setUpUI() {
        setUpViewController()
        setUpThumbnailImageView()
        setUpStackView()
    }
}

// MARK: - ViewController

extension EventDetailViewController {
    private func setUpViewController() {
        [thumbnailImageView, stackView].forEach { view.addSubview($0) }
        view.backgroundColor = .white
    }
}

// MARK: - Thumbnail ImageView

extension EventDetailViewController {
    private func setUpThumbnailImageView() {
        setConstraintsOfThumbnailImageView()
    }
    
    private func setConstraintsOfThumbnailImageView() {
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
}

// MARK: - StackView

extension EventDetailViewController {
    private func setUpStackView() {
        [nameLabel, locationLabel, titleLabel, commentLabel, priceLabel].forEach { stackView.addArrangedSubview($0) }
        setConstraintsOfStackView()
    }
    
    private func setConstraintsOfStackView() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10)
        ])
    }
}

// MARK: - Data Binding

extension EventDetailViewController {
    private func bindViewModel() {
        let input = EventDetailViewModel.Input(
            viewDidLoadEvent: Observable.just(())
        )
        let output = viewModel?.transform(from: input, disposeBag: disposeBag)
        
        bindLabels(output: output)
    }
    
    private func bindLabels(output: EventDetailViewModel.Output?) {
        nameLabel.text = output?.name.value
        locationLabel.text = output?.location.value
        titleLabel.text = output?.title.value
        commentLabel.text = output?.comment.value
        priceLabel.text = output?.price.value
    }
}
