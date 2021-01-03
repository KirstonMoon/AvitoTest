//
//  MainPresenter.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainPresenterLogic: class {
    func presentData(data: [List], images: [UIImage], title: String, buttonTitle: String)
}

final class MainPresenter {
    
    weak var viewController: MainDisplayLogic?
}

extension MainPresenter: MainPresenterLogic {
    func presentData(data: [List], images: [UIImage], title: String, buttonTitle: String) {
        viewController?.present(data: data, images: images, titleLabel: title, buttonText: buttonTitle)
    }
}
