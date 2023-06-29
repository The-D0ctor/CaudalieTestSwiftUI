//
//  MediaListViewModel.swift
//  CaudalieTest
//
//  Created by Sébastien Rochelet on 31/05/2023.
//

import UIKit
import Alamofire
import Combine

final class MediaListViewModel: ObservableObject {
    @Published var medias: [Media] = []
    @Published var isError: Bool = false
    @Published var error: AFError? = nil
    @Published var isGettingMedias = false
    
    static let url = "https://itunes.apple.com/search?"
    private var cancellableSet: Set<AnyCancellable> = []
    
    func getMediaList(title: String?) {
        isGettingMedias = true
        NetworkService.shared.getDecodable(url: "\(MediaListViewModel.url)\((title != nil) ? "term=\((title?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!)" : "")")
            .sink { [self] (dataresponse: DataResponse<GetMediaListResponse, AFError>) in
                if (dataresponse.error == nil) {
                    medias = dataresponse.value!.results
                }
                isError = dataresponse.error != nil
                error = dataresponse.error
                isGettingMedias = false
            }
            .store(in: &cancellableSet)
    }
}
