//
//  HomeViewController.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/08.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

final class HomeViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var viewModel: HomeViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemPink]
    }
    
    private func setUpUI() {
        setUpViewController()
        setUpNavigationBar()
        setUpTableView()
    }
}

// MARK: - ViewController

extension HomeViewController {
    private func setUpViewController() {
        view.addSubview(tableView)
        view.backgroundColor = .white
    }
}

// MARK: - Navigation Bar
extension HomeViewController {
    private func setUpNavigationBar() {
        navigationItem.title = "여신티켓"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemPink]
        navigationController?.navigationBar.tintColor = .black
    }
}

// MARK: - TableView

extension HomeViewController: UITableViewDelegate {
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.register(YeoshinEventsTableViewCell.self, forCellReuseIdentifier: YeoshinEventsTableViewCell.identifier)
        tableView.register(YeoshinTVsTableViewCell.self, forCellReuseIdentifier: YeoshinTVsTableViewCell.identifier)
        tableView.delegate = self
        setConstraintsOfTableView()
    }

    private func setConstraintsOfTableView() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func dataSource() -> RxTableViewSectionedReloadDataSource<HomeSection> {
            return RxTableViewSectionedReloadDataSource<HomeSection>(
                configureCell: { _, tableView, indexPath, item in
                    switch item {
                    case .yeoshinTVs(yeoshinTVs: let yeoshinTVs):
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: YeoshinTVsTableViewCell.identifier, for: indexPath) as? YeoshinTVsTableViewCell else { return UITableViewCell() }
                        cell.bindViewModel(with: yeoshinTVs)
                        return cell
                    case .yeoshinEvent(yeoshinEvent: let yeoshinEvent):
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: YeoshinEventsTableViewCell.identifier, for: indexPath) as? YeoshinEventsTableViewCell else { return UITableViewCell() }
                        cell.updateContent(with: yeoshinEvent)
                        return cell
                    }
                },
                titleForHeaderInSection: { dataSource, index in
                    let section = dataSource[index]
                    return section.title
                }
            )
        }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? UITableViewHeaderFooterView else { return }
        view.contentView.backgroundColor = .white
    }
}

// MARK: - Data Binding

extension HomeViewController {
    private func bindViewModel() {
        let input = HomeViewModel.Input(
            viewDidLoadEvent: Observable.just(()),
            cellDidSelectEvent: self.tableView.rx.itemSelected.map { ($0.section, $0.row) })
        let output = viewModel?.transform(from: input, disposeBag: disposeBag)

        bindTableView(output: output)
    }
    
    private func bindTableView(output: HomeViewModel.Output?) {
        let dateSource = dataSource()
        output?.sections
            .bind(to: tableView.rx.items(dataSource: dateSource))
            .disposed(by: disposeBag)
    }
}
