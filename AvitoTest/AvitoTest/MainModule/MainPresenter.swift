//
//  MainPresenter.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainPresenterLogic: class {
    func prepareDataForPresenting(dataResponse: DataResponse, dataImages: [UIImage])
}

final class MainPresenter {
    
    weak var viewController: MainDisplayLogic?
}

extension MainPresenter: MainPresenterLogic {
    func prepareDataForPresenting(dataResponse: DataResponse, dataImages: [UIImage]) {
        
        let viewModel = DataViewModel(title: dataResponse.result.title,
                                          buttonTitle: dataResponse.result.selectedActionTitle,
                                          dataArray: dataResponse.result.list,
                                          dataImagesArray: dataImages)

        
        viewController?.displayData(viewModel: viewModel)
    }
}
