//
//  ViewController.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainDisplayLogic: class {
    func displayData(title: String, buttonTitle: String, data: [List], images: [UIImage])
}

final class MainViewController: UIViewController {
    
    override func loadView() {
        view = MainView()
    }
    
    private var mainView: MainView {
        guard let view = view as? MainView else { fatalError("Could not create a view") }
        return view
    }
    
    private var selectedIndexPath: IndexPath?
    private var notSelectedIndexPath: IndexPath?
    private var selectedTitleString = "Выберете один из вариантов"
    
    private var fetchedDataArray: [List]?
    private var images: [UIImage]?
    
    var eventHandler: MainViewEventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargetToChooseButton()
        setupDelegateAndDataSource()
        self.eventHandler?.fetchData()
    }
    
    private func setupDelegateAndDataSource() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedDataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellId, for: indexPath) as! MainCollectionViewCell
        cell.titlelabel.text = fetchedDataArray?[indexPath.row].title
        cell.textLabel.text = fetchedDataArray?[indexPath.row].listDescription
        cell.priceLabel.text = fetchedDataArray?[indexPath.row].price
        cell.titleImageView.image = images?[indexPath.row]
        
        switch indexPath {
        case selectedIndexPath:
            cell.checkMarkButton.isHidden = false
            guard let cellTitleText = cell.titlelabel.text else { return UICollectionViewCell() }
            selectedTitleString = cellTitleText
        default:
            cell.checkMarkButton.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch selectedIndexPath {
        case indexPath:
            selectedIndexPath = notSelectedIndexPath
            selectedTitleString = "Выберете один из вариантов"
            mainView.collectionView.reloadData()
        default:
            selectedIndexPath = indexPath
            mainView.collectionView.reloadData()
        }
    }
}

extension MainViewController: MainDisplayLogic {
    
    func displayData(title: String, buttonTitle: String, data: [List], images: [UIImage]) {
        self.fetchedDataArray = data
        self.images = images
        mainView.titleLabel.text = title
        mainView.chooseButton.setTitle(buttonTitle, for: .normal)
        mainView.collectionView.reloadData()
        mainView.activityIndicator.stopAnimating()
        mainView.showUIelements()
    }
}

private extension MainViewController {
    @objc func didPressChooseButton() {
        
        let alert = UIAlertController(title: selectedTitleString, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func addTargetToChooseButton() {
        mainView.chooseButton.addTarget(self, action: #selector(didPressChooseButton), for: .touchUpInside)
    }
}
