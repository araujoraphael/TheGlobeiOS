//
//  StoryTableViewCell.swift
//  TheGlobeiOSTest
//
//  Created by Raphael Araújo on 2024-10-15.
//
import UIKit
import Kingfisher

class StoryTableViewCell: UITableViewCell {
    private(set) lazy var titleLabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var bylines = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private(set) lazy var promoImage = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
        bylines.text = nil
        promoImage.image = nil
    }
    
    func configure(with cellData: StoryCellData) {
        titleLabel.attributedText = cellData.headline
        bylines.text = cellData.bylines
        
        promoImage.kf.setImage(with: cellData.promoImage)
    }
}

extension StoryTableViewCell {
    private func setupViews() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(bylines)
        self.contentView.addSubview(promoImage)
        
        NSLayoutConstraint.activate([
            promoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            promoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            promoImage.heightAnchor.constraint(equalToConstant: 100),
            promoImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: promoImage.leadingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            bylines.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bylines.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            bylines.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            bylines.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
