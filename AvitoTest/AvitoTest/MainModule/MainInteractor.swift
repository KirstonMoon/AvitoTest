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
    var titleString: String? { get set }
    var itemsList: [List]? { get set }
    var titleLabelString: String? { get set }
    var buttonText: String? { get set }
}

final class MainInteractor {
    
    var presenter: MainPresenterLogic
    let networkService: NetworkServiceProtocol
    
    var titleString: String?
    var itemsList: [List]?
    var titleLabelString: String?
    var buttonText: String?
    
    var images = [UIImage]()


    
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
                    self.titleString = resultData.result.title
                    self.itemsList = resultData.result.list
                    self.titleLabelString = resultData.result.title
                    self.buttonText = resultData.result.selectedActionTitle
                    
                    for imageURL in resultData.result.list {
                        let image = UIImage(data: try! Data(contentsOf: URL(string: imageURL.icon.the52X52)!))
                        self.images.append(image ?? UIImage())
                    }
                    
                    guard let items = self.itemsList else { return }
                    self.presenter.presentData(data: items, images: self.images, title: self.titleLabelString, buttonTitle: self.buttonText)
                    
                case .failure(let error):
                    print(error.localizedDescription as Any)
                }
            }
        }
    }
}
