//
//  ProductCell.swift
//  KreditPlus
//
//  Created by Novi Gunawan on 05/09/22.
//

import UIKit

protocol UpdateTableView: AnyObject {
    func update(indexPath: [IndexPath])
}
class ProductCell: UITableViewCell {
    let card: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 13.0
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0.0,height: 1.0)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        return stackView
    }()
    let priceLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    let titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 3
        label.sizeToFit()
        return label
    }()
    
    let descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    var indexPathTableView: IndexPath = IndexPath(row: 0, section: 0)
    let image: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 13.0
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: Constant.imagePlaceholder)
        return image
    }()
    let ratingImage: UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: Constant.Image.star)
        image.tintColor = .black
        return image
    }()
    weak var delegate: UpdateTableView?
    var productViewModel: ProductViewModel! {
        didSet {
            delegate?.update(indexPath: [indexPathTableView])
            titleLabel.text = productViewModel.title
            descriptionLabel.text = productViewModel.description
            priceLabel.text = "$ \(productViewModel.price)"
            ratingLabel.text = "\(productViewModel.rating)"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default , reuseIdentifier: reuseIdentifier)
        // MARK: Cell Customization
        image.contentMode = .scaleAspectFit
        setupView()
        setupConstraint()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupView() {
        self.contentView.addSubview(card)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(image)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(ratingImage)
        horizontalStackView.addArrangedSubview(ratingLabel)
    }
    
    fileprivate func setupConstraint() {
        let marginGuide = contentView.layoutMarginsGuide
        card.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingImage.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        cardConstraint(guide: marginGuide)
        titleLabelConstraint()
        imageConstraint()
        descriptionLabelConstraint()
        priceLabelConstraint()
        horizontalStackViewConstraint()
        print("Card: \(card.frame.width)")
        
    }
    fileprivate func cardConstraint(guide: UILayoutGuide) {
        card.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        card.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        card.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        card.trailingAnchor.constraint(equalTo:  guide.trailingAnchor).isActive = true
    }
    fileprivate func priceLabelConstraint() {
        priceLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 8).isActive = true
        priceLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 10).isActive = true
    }
    fileprivate func imageConstraint() {
        image.topAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 20).isActive = true
        image.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -2).isActive = true
        image.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 2).isActive = true
        image.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    fileprivate func titleLabelConstraint() {
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30).isActive = true
    }
    fileprivate func descriptionLabelConstraint() {
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -30).isActive = true
    }
    fileprivate func horizontalStackViewConstraint() {
        horizontalStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor).isActive = true
    }
}
