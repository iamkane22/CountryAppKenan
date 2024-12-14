//
//  MainViewController.swift
//  CountryAppKenan
//
//  Created by Kenan on 14.12.24.
//

import UIKit

final class MainViewController: BaseViewController {
    private lazy var refreshController: UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self, action: #selector(reloadPage), for: .valueChanged)
        return r
    }()
    
    private lazy var searchField: UITextField = {
        let t = UITextField()
        t.placeholder = "Search"
        t.delegate = self
        t.borderStyle = .roundedRect
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.layer.borderWidth = 1
        t.layer.cornerRadius = 12
        t.anchorSize(.init(width: 0, height: 56))
        return t
    }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(cell: TitleSubtitleCell.self)
        t.separatorStyle = .none
        t.refreshControl = refreshController
        return t
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .large)
        v.tintColor = .red
        return v
    }()
    
    private lazy var submitButton: UIButton = {
        let b = UIButton()
        b.setTitle("Create", for: .normal)
        b.backgroundColor = .red
        b.titleLabel?.textColor = .white
        b.anchorSize(.init(width: 0, height: 56))
        return b
    }()
    
    
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        viewModel.getCountryListRequest()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubViews(table, loadingView, submitButton, searchField)
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        loadingView.fillSuperview()
        searchField.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: -20)
        )
        
        table.anchor(
            top: searchField.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 4, left: 20, bottom: 0, right: -20)
        )
        
        submitButton.anchor(
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,padding: .init(all: 20))
    }
    
    override func configureTargets() {
        super.configureTargets()
        submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
    }
    
    fileprivate func configureViewModel() {
        
        viewModel.listener = { [weak self] state in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch state {
                    case .loading:
                        self.loadingView.startAnimating()
                    case .loaded:
                        self.loadingView.stopAnimating()
                        self.refreshController.endRefreshing()
                    case .success:
                        self.table.reloadData()
                    case .error(let message):
                        self.showMessage(title: "Xeta", message: message)
                }
            }
        }
    }
    
    //MARK: Private Functions
    
    fileprivate func showCountryDetail(country: CountryDTO) {
        let controller = CountryDetailController(viewModel: .init(country: country))
        navigationController?.show(controller, sender: nil)
    }
    
    @objc
    private func submitButtonClicked() {
        viewModel.sortedAToZList()
    }
    
    @objc
    private func reloadPage() {
        viewModel.getCountryListRequest()
    }
}
//MARK: UITableViewDelegate,UITableViewDataSource
extension MainViewController: UITableViewDelegate,
                              UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.getItems()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: TitleSubtitleCell.self, for: indexPath)
        guard let item = viewModel.getProtocol(index: indexPath.row) else {return UITableViewCell()}
        cell.configureCell(model: item)
        return cell
    }
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let item = viewModel.getItem(index: indexPath.row) else {return}
        showCountryDetail(country: item)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        viewModel.search(text: text)
        print(text)
    }
}
