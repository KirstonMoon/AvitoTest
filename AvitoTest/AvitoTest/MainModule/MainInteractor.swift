//
//  MainInteractor.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainInteractorLogic: class {
    
    init(presenter: MainPresenterLogic, networkService: NetworkServiceProtocol)
    
    func fetchDataFromJson()
    var data: DataResponse? { get set }
    var dataImages: [UIImage]? { get set }
}

final class MainInteractor {
    
    var presenter: MainPresenterLogic
    let networkService: NetworkServiceProtocol
    
    var data: DataResponse?
    var dataImages: [UIImage]?
    
    init(presenter: MainPresenterLogic, networkService: NetworkServiceProtocol) {
        self.presenter = presenter
        self.networkService = networkService
    }
}

extension MainInteractor: MainInteractorLogic {
    func fetchDataFromJson() {
        networkService.getComments { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let resultData):
                    guard let resultData = resultData else { return }
                    self.data = resultData
                    self.dataImages = [UIImage]()
                    
                    for imageURL in resultData.result.list {
                        guard let url = URL(string: imageURL.icon.the52X52),
                              let image = UIImage(data: try! Data(contentsOf: url)) else { return }
                        self.dataImages?.append(image)
                    }
                    
                    guard let data = self.data,
                          let images = self.dataImages else { return }
                    self.presenter.prepareDataForPresenting(dataResponse: data, dataImages: images)
                    
                case .failure(let error):
                    print(error.localizedDescription as Any)
                }
            }
        }
    }
}
