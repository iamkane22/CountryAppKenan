//
//  QuizTableCell.swift
//  CountryAppKenan
//
//  Created by Kenan on 18.12.24.
//

import UIKit

final class QuizTableCell: UITableViewCell {
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.text = "Which country's flag is this?"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: QuizProtocol) {
        countryNameLabel.text = model.countryNameTitle
        
    }
    
    fileprivate func setupConstraints() {
        contentView.addSubview(questionLabel)
        contentView.addSubview(countryNameLabel)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            questionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            questionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            questionLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            countryNameLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor),
            countryNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            countryNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            countryNameLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
