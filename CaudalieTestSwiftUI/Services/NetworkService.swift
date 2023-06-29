//
//  NetworkService.swift
//  CaudalieTestSwiftUI
//
//  Created by Sébastien Rochelet on 06/06/2023.
//

import Foundation
import Alamofire
import Combine

final class NetworkService {
    static let shared = NetworkService()
        private init() { }
    
    func getDecodable<T: Decodable>(url: String) -> AnyPublisher<DataResponse<T, AFError>, Never> {
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: T.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
