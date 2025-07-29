//
//  TravelFeedViewModel.swift
//  PLEP
//
//  Created by 이다경 on 7/29/25.
//

import RxSwift
import Combine

class TravelFeedViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    private let feedApi = FeedApi()
    
    @Published var feeds: [FeedModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func fetchFeeds() {
        isLoading = true
        feedApi.getFeeds()
            .subscribe { [weak self] response in
                guard let self = self else { return }
                self.isLoading = false
                self.feeds = response.data
                print("피드 가져오기 성공: \(self.feeds)")
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                self.isLoading = false
                self.errorMessage = error.localizedDescription
                print("피드 가져오기 실패: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
}
