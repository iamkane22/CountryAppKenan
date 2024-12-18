//
//  Untitled.swift
//  CountryAppKenan
//
//  Created by Kenan on 18.12.24.
//

import UIKit

final class QuizController: BaseViewController {
    
    private lazy var quizTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 96
        return table
    }()
    
    
    private let viewModel: QuizViewModel
    
    init (viewModel: QuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureTable() {
        quizTableView.delegate = self
        quizTableView.dataSource = self
        quizTableView.register(QuizTableCell.self, forCellReuseIdentifier: "QuizTableCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(quizTableView)
        quizTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        
        quizTableView.fillSuperviewSafeAreaLayoutGuide()
    }
}

extension QuizController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableCell", for: indexPath) as! QuizTableCell
        
        if let item = viewModel.getItem(index: indexPath.row) {
            DispatchQueue.main.async {
                self.viewModel.listener = { [weak self] in
                    guard let self = self else {return}
                    
                    self.quizTableView.reloadData()
                    
                }
            }   
            cell.configureCell(model: item)
            
        }
        
        return cell
    }
}


