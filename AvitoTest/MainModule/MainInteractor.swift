//
//  MainInteractor.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainInteractorLogic: AnyObject {
    func loadDataFromJson()
    var recievedData: DataResponse? { get set }
    var recievedImages: [UIImage]? { get set }
    init(networkService: NetworkServiceProtocol)
}

final class MainInteractor {
    
    weak var presenter: MainPresenterLogic?
    var networkService: NetworkServiceProtocol
    
    var recievedData: DataResponse?
    var recievedImages: [UIImage]?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension MainInteractor: MainInteractorLogic {
    func loadDataFromJson() {
        networkService.getDataFromJson { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let resultData):
                    guard let resultData = resultData else { return }
                    self.recievedData = resultData
                    self.recievedImages = [UIImage]()
                    
                    resultData.result.list.forEach { url in
                        guard let imgUrl = URL(string: url.icon.the52X52), let image = UIImage(data: try! Data(contentsOf: imgUrl)) else { return }
                        self.recievedImages?.append(image)
                        
                    }
                    
                    guard let data = self.recievedData, let images = self.recievedImages else { return }
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
