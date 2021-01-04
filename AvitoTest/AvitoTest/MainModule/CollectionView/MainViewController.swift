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
    
    var selectedIndex: Int?
    var selectedTitleString: String?
    
    var interactor: MainInteractorLogic?
    
    private var list: [List]?
    private var images: [UIImage]?
    
    var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        interactor?.fetchDataFromJson()
        setupView()
    }
    
    private func setupView() {
        setupCloseMarkView()
        setupTitleLabel()
        setupChooseButton()
        addTargetToChooseButton()
        setupCollectionView()
    }
    
    let closeMarkView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "CloseIconTemplate")
        theImageView.translatesAutoresizingMaskIntoConstraints = false
        return theImageView
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
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellId, for: indexPath) as! MainCollectionViewCell
        cell.titlelabel.text = list?[indexPath.row].title
        cell.textLabel.text = list?[indexPath.row].listDescription
        cell.priceLabel.text = list?[indexPath.row].price
        cell.titleImageView.image = self.images?[indexPath.row]
        
        if indexPath.row == selectedIndex {
            cell.checkMarkButton.isHidden = false
            self.selectedTitleString = cell.titlelabel.text
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

