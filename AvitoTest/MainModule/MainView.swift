//
//  MainView.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 05.01.2021.
//

import UIKit

final class MainView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupView()
    }
    
    var collectionView: UICollectionView!
    
    private func setupAppearance() {
        backgroundColor = .systemBackground
    }
    
    private func setupView() {
        setupActivityIndicator()
        setupCloseMarkView()
        setupTitleLabel()
        setupChooseButton()
        setupCollectionView()
    }
    
    func showUIelements() {
        closeMarkView.isHidden = false
        titleLabel.isHidden = false
        chooseButton.isHidden = false
    }
    
    private let closeMarkView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "CloseIconTemplate")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemGray
        return activityIndicator
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 27)
        return label
    }()
    
    let chooseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.backgroundColor = #colorLiteral(red: 0, green: 0.6754948497, blue: 1, alpha: 1)
        return button
    }()
    
    private func setupChooseButton() {
        addSubview(chooseButton)
        chooseButton.isHidden = true
        NSLayoutConstraint.activate([
            chooseButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            chooseButton.heightAnchor.constraint(equalToConstant: 50),
            chooseButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            chooseButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.isHidden = true
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -40)
        ])
    }
    
    private func setupCloseMarkView() {
        addSubview(closeMarkView)
        closeMarkView.isHidden = true
        NSLayoutConstraint.activate([
            closeMarkView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            closeMarkView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
        ])
    }
    
    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35)
        ])
    }
    
    private func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 310, height: 165)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: chooseButton.topAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
