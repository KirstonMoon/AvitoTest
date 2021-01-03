//
//  ViewController.swift
//  AvitoTest
//
//  Created by Kirill Magerya on 02.01.2021.
//

import UIKit

protocol MainDisplayLogic: class {
    
}

final class MainViewController: UIViewController {

    var interactor: MainInteractorLogic?
    
    var string = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        interactor?.fetchDataFromJson()
    }


}

extension MainViewController: MainDisplayLogic {
    
}
