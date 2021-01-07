//
//  ModuleBuilder.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol Builder {
    
    static func createMain() -> UIViewController
}

final class ModuleBuilder: Builder {
    
    static func createMain() -> UIViewController {
        
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        
        view.eventHandler = presenter
        presenter.interactor = interactor
        presenter.viewController = view
        interactor.networkService = networkService
        interactor.presenter = presenter
        
        return view
    }
}
