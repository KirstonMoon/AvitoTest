//
//  ViewController.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainDisplayLogic: class {
    func displayData(viewModel: DataViewModel)
}

final class MainViewController: UIViewController {
    
    var selectedIndex: Int?
    var selectedTitleString: String?
    
    var interactor: MainInteractorLogic?
    
    private var fetchedDataArray: [List]?
    private var images: [UIImage]?
    
    var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        interactor?.fetchDataFromJson()
        setupView()
    }
    
    private func setupView() {
        setupActivityIndicator()
        setupCloseMarkView()
        setupTitleLabel()
        setupChooseButton()
        addTargetToChooseButton()
        setupCollectionView()
    }
    
    private func showLayoutElements() {
        closeMarkView.isHidden = false
        titleLabel.isHidden = false
        chooseButton.isHidden = false
    }
    
    //MARK: - UI Elements
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        return activityIndicator
    }()
    
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
        return fetchedDataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellId, for: indexPath) as! MainCollectionViewCell
        cell.titlelabel.text = fetchedDataArray?[indexPath.row].title
        cell.textLabel.text = fetchedDataArray?[indexPath.row].listDescription
        cell.priceLabel.text = fetchedDataArray?[indexPath.row].price
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

    func displayData(viewModel: DataViewModel) {
        self.fetchedDataArray = viewModel.dataArray
        self.images = viewModel.dataImagesArray
        self.titleLabel.text = viewModel.title
        self.chooseButton.setTitle(viewModel.buttonTitle, for: .normal)
        collectionview.reloadData()
        activityIndicator.stopAnimating()
        showLayoutElements()
    }
}

