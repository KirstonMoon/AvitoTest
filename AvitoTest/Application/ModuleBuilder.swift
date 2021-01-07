//
//  ModuleBuilder.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol Builder {
    
    static func createMainVC() -> UIViewController
}

final class ModuleBuilder: Builder {
    
    static func createMainVC() -> UIViewController {
        
        let view = MainViewController()
        let networkService = NetworkService()
        let interactor = MainInteractor(networkService: networkService)
        let presenter = MainPresenter(interactor: interactor)

        view.eventHandler = presenter
        presenter.interactor = interactor
        presenter.view = view
        interactor.networkService = networkService
        interactor.presenter = presenter
        
        return view
    }
}
