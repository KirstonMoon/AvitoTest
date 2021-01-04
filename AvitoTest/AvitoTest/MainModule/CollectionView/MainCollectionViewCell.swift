//
//  CollectionViewCell.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 03.01.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    static let cellId = "Cell"
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.9724745154, green: 0.9725908637, blue: 0.9724350572, alpha: 1)
        setupTitleLabel()
        setupTextLabel()
        setupPriceLabel()
        setupCheckmarkButton()
        setupImageView()
       // setupActivityIndicator()
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        return activityIndicator
    }()
    
    let titlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Объявление"
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.text = "Описание"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Цена ₽"
        return label
    }()
    
    let checkMarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "checkmark"), for: .normal)
        return button
    }()
    
    let titleImageView: UIImageView = {
           let theImageView = UIImageView()
           theImageView.image = UIImage()
           theImageView.translatesAutoresizingMaskIntoConstraints = false
           return theImageView
        }()
    
    private func setupTitleLabel() {
        addSubview(titlelabel)
        NSLayoutConstraint.activate([
            titlelabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titlelabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 80),
            titlelabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50)
        ])
    }
    
    private func setupTextLabel() {
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 9),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 80),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40)
        ])
    }
    
    private func setupPriceLabel() {
        addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 80),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50)
        ])
    }
    
    private func setupCheckmarkButton() {
        addSubview(checkMarkButton)
        checkMarkButton.isHidden = true
        NSLayoutConstraint.activate([
            checkMarkButton.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            checkMarkButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -17)
        ])
    }
    
    private func setupImageView() {
        addSubview(titleImageView)
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleImageView.heightAnchor.constraint(equalToConstant: 50),
            titleImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
