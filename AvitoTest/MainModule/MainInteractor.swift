//
//  MainInteractor.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainInteractorLogic: class {
    
    func loadDataFromJson()
    
    var data: DataResponse? { get set }
    var dataImages: [UIImage]? { get set }
    
    init(networkService: NetworkServiceProtocol)
}

final class MainInteractor {
    
    weak var presenter: MainPresenterLogic?
    var networkService: NetworkServiceProtocol
    
    var data: DataResponse?
    var dataImages: [UIImage]?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension MainInteractor: MainInteractorLogic {
    func loadDataFromJson() {
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
                    
                    self.presenter?.recieveData(dataViewModel: DataViewModel(title: resultData.result.title,
                                                                            buttonTitle: resultData.result.selectedActionTitle,
                                                                            dataArray: data.result.list,
                                                                            dataImagesArray: images))
                    
                case .failure(let error):
                    print(error.localizedDescription as Any)
                }
            }
        }
    }
}
