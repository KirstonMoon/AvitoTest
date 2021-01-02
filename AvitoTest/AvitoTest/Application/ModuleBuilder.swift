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

class ModuleBuilder: Builder {
    
    static func createMain() -> UIViewController {
        
        let view = MainViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        
        interactor.presenter = presenter
        presenter.viewController = view
        view.interactor = interactor
        
        return view
    }
}
