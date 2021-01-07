//
//  MainPresenter.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainPresenterLogic: AnyObject {
    func recieveData(dataViewModel: DataViewModel)
    init(interactor: MainInteractorLogic)
}

protocol MainViewEventHandler {
    func fetchData()
}

final class MainPresenter {
    
    weak var view: MainDisplayLogic?
    var interactor: MainInteractorLogic
    
    init(interactor: MainInteractorLogic) {
        self.interactor = interactor
    }
}

extension MainPresenter: MainPresenterLogic {
    
    func recieveData(dataViewModel: DataViewModel) {
        let dataArray = dataViewModel.dataArray
        let imagesArray = dataViewModel.dataImagesArray
        let title = dataViewModel.title
        let buttonTitle = dataViewModel.buttonTitle
        view?.displayData(title: title, buttonTitle: buttonTitle,
                                         fetchedData: dataArray, fetchedImages: imagesArray)
    }
}

extension MainPresenter: MainViewEventHandler {
    
    func fetchData() {
        interactor.loadDataFromJson()
    }
}
