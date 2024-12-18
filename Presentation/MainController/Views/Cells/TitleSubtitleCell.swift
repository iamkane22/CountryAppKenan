//
//  TitleSubtitleCell.swift
//  CountryAppKenan
//
//  Created by Kenan on 14.12.24.
//

import UIKit

final class TitleSubtitleCell: UITableViewCell {
    private lazy var iconImage: UIImageView = {
        let i = UIImageView()
        i.anchorSize(.init(width: 64, height: 32))
        i.backgroundColor = .clear
        i.layer.borderColor = UIColor.lightGray.cgColor
        i.layer.borderWidth = 1
        i.layer.cornerRadius = 4
        i.layer.masksToBounds = true
        return i
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Test"
        l.textAlignment = .left
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .label
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Test"
        l.textAlignment = .left
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        l.textColor = .secondaryLabel
        return l
    }()
    
    private lazy var titleStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        s.axis = .vertical
        s.spacing = 4
        s.alignment = .fill
        s.distribution = .fill
        return s
    }()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [iconImage, titleStackView])
        s.axis = .horizontal
        s.spacing = 12
        s.alignment = .center
        s.distribution = .fill
        return s
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 0, bottom: -12, right: 0))
    }
    
    func configureCell(model: TitleSubtitleProtocol) {
        titleLabel.text = model.titleString
        subtitleLabel.text = model.subtitleString
        iconImage.loadImageURL(url: model.iconURL)
    }
}

