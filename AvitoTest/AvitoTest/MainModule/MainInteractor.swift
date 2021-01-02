//
//  MainInteractor.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import Foundation

protocol MainInteractorLogic: class {
    
}

final class MainInteractor {
    
    var presenter: MainPresenterLogic?
}

extension MainInteractor: MainInteractorLogic {
   
}
