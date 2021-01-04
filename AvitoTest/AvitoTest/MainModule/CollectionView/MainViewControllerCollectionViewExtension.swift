//
//  MainViewControllerCollectionViewExtension.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 05.01.2021.
//

import UIKit

extension MainViewController {
    
    // MARK: - Button setup
    
    func addTargetToChooseButton() {
        chooseButton.addTarget(self, action: #selector(didPressChooseButton), for: .touchUpInside)
    }
    
    @objc func didPressChooseButton() {
        
        if self.selectedTitleString == nil {
            let alert = UIAlertController(title: "Выберете один из вариантов", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: self.selectedTitleString, message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func setupChooseButton() {
        view.addSubview(chooseButton)
        chooseButton.isHidden = true
        NSLayoutConstraint.activate([
            chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            chooseButton.heightAnchor.constraint(equalToConstant: 50),
            chooseButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            chooseButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    // MARK: - Setup title label
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.isHidden = true
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -40)
        ])
    }
    
    // MARK: - Setup closeMark view
    
    func setupCloseMarkView() {
        view.addSubview(closeMarkView)
        closeMarkView.isHidden = true
        NSLayoutConstraint.activate([
            closeMarkView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            closeMarkView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
        ])
    }
    
    // MARK: - Setup activity indicator
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35)
        ])
    }
    
    // MARK: - Setup Collection view
    
    func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 310, height: 165)
        
        collectionview = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = .white
        view.addSubview(collectionview)
        
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30),
            collectionview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionview.bottomAnchor.constraint(equalTo: self.chooseButton.topAnchor, constant: -5)
        ])
    }
}
