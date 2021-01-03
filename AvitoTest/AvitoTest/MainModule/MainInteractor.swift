//
//  MainInteractor.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import Foundation

protocol MainInteractorLogic: class {
    
    init(presenter: MainPresenterLogic, networkService: NetworkServiceProtocol)
    
    func fetchDataFromJson()
    var titleString: String? { get set }
    var itemsList: [List]? { get set }
}

final class MainInteractor {
    
    var presenter: MainPresenterLogic
    let networkService: NetworkServiceProtocol
    
    var titleString: String?
    var itemsList: [List]?
    
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
                    self.titleString = resultData?.result.title
                    self.itemsList = resultData?.result.list
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
