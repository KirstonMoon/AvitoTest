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
    
    override func loadView() {
        view = MainView()
    }
    
    private var mainView: MainView {
        guard let view = view as? MainView else { fatalError("Could not create a view") }
        return view
    }
    
    static var selectedIndex: Int?
    static var selectedTitleString: String?
    
    var interactor: MainInteractorLogic?
    
    private var fetchedDataArray: [List]?
    private var images: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargetToChooseButton()
        setupDelegateAndDataSource()
        interactor?.fetchDataFromJson()
    }
    
    private func setupDelegateAndDataSource() {
        mainView.collectionview.delegate = self
        mainView.collectionview.dataSource = self
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedDataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionview.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellId, for: indexPath) as! MainCollectionViewCell
        cell.titlelabel.text = fetchedDataArray?[indexPath.row].title
        cell.textLabel.text = fetchedDataArray?[indexPath.row].listDescription
        cell.priceLabel.text = fetchedDataArray?[indexPath.row].price
        cell.titleImageView.image = images?[indexPath.row]
        
        if indexPath.row == MainViewController.selectedIndex {
            cell.checkMarkButton.isHidden = false
            MainViewController.selectedTitleString = cell.titlelabel.text
        } else {
            cell.checkMarkButton.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        MainViewController.selectedIndex = indexPath.row
        mainView.collectionview.reloadData()
    }
}

extension MainViewController: MainDisplayLogic {

    func displayData(viewModel: DataViewModel) {
        fetchedDataArray = viewModel.dataArray
        images = viewModel.dataImagesArray
        mainView.titleLabel.text = viewModel.title
        mainView.chooseButton.setTitle(viewModel.buttonTitle, for: .normal)
        mainView.collectionview.reloadData()
        mainView.activityIndicator.stopAnimating()
        mainView.showUIelements()
    }
}

private extension MainViewController {
    @objc func didPressChooseButton() {
        
        if MainViewController.selectedTitleString == nil {
            let alert = UIAlertController(title: "Выберете один из вариантов", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: MainViewController.selectedTitleString, message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func addTargetToChooseButton() {
        mainView.chooseButton.addTarget(self, action: #selector(didPressChooseButton), for: .touchUpInside)
    }
}
