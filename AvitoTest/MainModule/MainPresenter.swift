//
//  MainPresenter.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainPresenterLogic: class {
    func recieveData(dataViewModel: DataViewModel)
}

protocol MainViewEventHandler {
    func fetchData()
}

final class MainPresenter {
    
    weak var viewController: MainDisplayLogic?
    var interactor: MainInteractorLogic?
}

extension MainPresenter: MainPresenterLogic {
    
    func recieveData(dataViewModel: DataViewModel) {
        let dataArray = dataViewModel.dataArray
        let imagesArray = dataViewModel.dataImagesArray
        let title = dataViewModel.title
        let buttonTitle = dataViewModel.buttonTitle
        viewController?.displayData(title: title, buttonTitle: buttonTitle,
                                         data: dataArray, images: imagesArray)
    }
}

extension MainPresenter: MainViewEventHandler {
    
    func fetchData() {
        interactor?.loadDataFromJson()
    }
}
