//
//  NetworkService.swift
//  Test
//
//  Created by Kirill Magerya on 29.12.2020.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func getDataFromJson(completion: @escaping (Result<DataResponse?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func getDataFromJson(completion: @escaping (Result<DataResponse?, Error>) -> Void) {
        
        let urlString = "https://raw.githubusercontent.com/avito-tech/internship/main/result.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                if let data = data {
                    let object = try JSONDecoder().decode(DataResponse.self, from: data)
                    completion(.success(object))
                }
                
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
}
