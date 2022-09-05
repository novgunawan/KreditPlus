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
    let priceLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        return label
    }()
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    let titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = .black
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
    weak var delegate: UpdateTableView?
    var productViewModel: ProductViewModel! {
        didSet {
            titleLabel.text = productViewModel.title
            descriptionLabel.text = productViewModel.description
            priceLabel.text = "$ \(productViewModel.price)"
            
            delegate?.update(indexPath: [indexPathTableView])
            print("IndexPath passed: \(indexPathTableView)")
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
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(image)

        //        self.contentView.addSubview(descriptionLabel)
        //        self.contentView.addSubview(ratingLabel)
        //        self.contentView.addSubview(priceLabel)
    }
    
    fileprivate func setupConstraint() {
        let marginGuide = contentView.layoutMarginsGuide
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabelConstraint(guide: marginGuide)
        imageConstraint(guide: marginGuide)

        //        descriptionLabelConstraint(guide: marginGuide)
        //        priceLabelConstraint(guide: marginGuide)
        //        ratingLabelConstraint(guide: marginGuide)
        
    }
    
    fileprivate func priceLabelConstraint(guide: UILayoutGuide) {
        
    }
    fileprivate func ratingLabelConstraint(guide: UILayoutGuide) {
        
    }
    fileprivate func imageConstraint(guide: UILayoutGuide) {
        image.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 140).isActive = true
        image.widthAnchor.constraint(equalToConstant: 140).isActive = true
    }
    fileprivate func titleLabelConstraint(guide: UILayoutGuide) {
                titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
    }
    fileprivate func descriptionLabelConstraint(guide: UILayoutGuide) {
        
    }
}
