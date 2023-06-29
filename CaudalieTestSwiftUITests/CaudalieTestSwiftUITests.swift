//
//  CaudalieTestSwiftUITests.swift
//  CaudalieTestSwiftUITests
//
//  Created by Sébastien Rochelet on 05/06/2023.
//

import XCTest
import Combine
@testable import Alamofire

final class CaudalieTestSwiftUITests: XCTestCase {
    private var cancellableSet: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testValidApiCall() {
        let url = "https://itunes.apple.com/search?term=test"
        let promise = expectation(description: "Status code: 200")
        
        AF.request(url, method: .get)
            .validate()
            .publishUnserialized()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink() { dataresponse in
                if dataresponse.error != nil {
                    XCTFail("Error: \(dataresponse.error!.localizedDescription)")
                } else if dataresponse.response?.statusCode != 200 {
                    XCTFail("Status code: \((dataresponse.response?.statusCode)!)")
                }
                else {
                    promise.fulfill()
                }
            }
            .store(in: &cancellableSet)
        wait(for: [promise], timeout: 5)
    }
    
    func testEmptyQuery() {
        let url = "https://itunes.apple.com/search"
        
        let promise = expectation(description: "List returned empty")
        AF.request(url, method: .get)
            .validate()
            .publishUnserialized()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink() { dataresponse in
                if dataresponse.error != nil {
                    XCTFail("Error: \(dataresponse.error!.localizedDescription)")
                    return
                }
                if let json = try? JSONSerialization.jsonObject(with: dataresponse.value!!, options: .mutableContainers) {
                    guard let dic = json as? [String: Any], let resultCount = dic["resultCount"] as? Int
                    else {
                        XCTFail("Deserialization error")
                        return
                    }
                    if resultCount != 0 {
                        XCTFail("List returned not empty")
                    }
                    else {
                        promise.fulfill()
                    }
                }
            }
            .store(in: &cancellableSet)
        wait(for: [promise], timeout: 5)
    }
    
    func testInvalidQuery() {
        let url = "https://itunes.apple.com/search?test=test"
        
        let promise = expectation(description: "List returned empty")
        AF.request(url, method: .get)
            .validate()
            .publishUnserialized()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink() { dataresponse in
                if dataresponse.error != nil {
                    XCTFail("Error: \(dataresponse.error!.localizedDescription)")
                    return
                }
                if let json = try? JSONSerialization.jsonObject(with: dataresponse.value!!, options: .mutableContainers) {
                    guard let dic = json as? [String: Any], let resultCount = dic["resultCount"] as? Int
                    else {
                        XCTFail("Deserialization error")
                        return
                    }
                    if resultCount != 0 {
                        XCTFail("List returned not empty")
                    }
                    else {
                        promise.fulfill()
                    }
                }
            }
            .store(in: &cancellableSet)
        wait(for: [promise], timeout: 5)
    }
}
