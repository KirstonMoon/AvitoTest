//
//  ViewController.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainDisplayLogic: class {
    func present(data: [List], images: [UIImage], titleLabel: String, buttonText: String)
}

final class MainViewController: UIViewController {
    
    private var selectedIndex: Int?
    private var selectedString: String?
    
    var interactor: MainInteractorLogic?
    
    private var list: [List]?
    private var images: [UIImage]?
    
    private var collectionview: UICollectionView!
    private let cellId = "Cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        interactor?.fetchDataFromJson()
        setupCloseMarkView()
        setupTitleLabel()
        setupChooseButton()
        addTargetToChooseButton()
        setupCollectionView()
    }
    
    private let closeMarkView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "CloseIconTemplate")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
    }()
    
    private func setupCloseMarkView() {
        view.addSubview(closeMarkView)
        NSLayoutConstraint.activate([
            closeMarkView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            closeMarkView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
        ])
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 27)
        return label
    }()
    
    private let chooseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.backgroundColor = #colorLiteral(red: 0, green: 0.6754948497, blue: 1, alpha: 1)
        return button
    }()
    
    @objc private func didPressChooseButton() {
        
        if self.selectedString == nil {
            let alert = UIAlertController(title: "Выберете один из вариантов", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: self.selectedString, message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
        

        
        
    }
    
    private func addTargetToChooseButton() {
        chooseButton.addTarget(self, action: #selector(didPressChooseButton), for: .touchUpInside)
    }
    
    private func setupChooseButton() {
        view.addSubview(chooseButton)
        NSLayoutConstraint.activate([
            chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            chooseButton.heightAnchor.constraint(equalToConstant: 50),
            chooseButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            chooseButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -40)
        ])
    }
    
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainCollectionViewCell
        cell.titlelabel.text = list?[indexPath.row].title
        cell.textLabel.text = list?[indexPath.row].listDescription
        cell.priceLabel.text = list?[indexPath.row].price
        cell.titleImageView.image = self.images?[indexPath.row]
        
        if indexPath.row == selectedIndex {
            cell.checkMarkButton.isHidden = false
            self.selectedString = cell.titlelabel.text
        } else {
            cell.checkMarkButton.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionview.reloadData()
    }
}

extension MainViewController: MainDisplayLogic {
    func present(data: [List], images: [UIImage], titleLabel: String, buttonText: String) {
        self.list = data
        self.images = images
        self.titleLabel.text = titleLabel
        self.chooseButton.setTitle(buttonText, for: .normal)
        collectionview.reloadData()
    }
    
}

private extension MainViewController {
    
    func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 310, height: 165)
        
        collectionview = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
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
