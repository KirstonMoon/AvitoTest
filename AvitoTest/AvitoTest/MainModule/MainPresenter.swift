//
//  MainPresenter.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import Foundation

protocol MainPresenterLogic: class {
    
}

final class MainPresenter {
    
    weak var viewController: MainDisplayLogic?
}

extension MainPresenter: MainPresenterLogic {
    
}
