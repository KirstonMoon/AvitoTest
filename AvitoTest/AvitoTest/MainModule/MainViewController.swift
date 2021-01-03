//
//  ViewController.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainDisplayLogic: class {
    func present(data: [List], images: [UIImage])
}

final class MainViewController: UIViewController {
    
    private var selectedIndex: Int?
    
    var interactor: MainInteractorLogic?
    
    private var list: [List]?
    private var images: [UIImage]?
    
    private var collectionview: UICollectionView!
    private let cellId = "Cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchDataFromJson()
        setupCollectionView()
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
    func present(data: [List], images: [UIImage]) {
        self.list = data
        self.images = images
        collectionview.reloadData()
    }

}

private extension MainViewController {
    
    func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 120, left: 0, bottom: 100, right: 0)
        layout.itemSize = CGSize(width: 310, height: 165)
        
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
    }
}
