//
//  ProfileFeedViewModel.swift
//  PLEP
//
//  Created by 이다경 on 7/30/25.
//

import RxSwift
import Combine
import SwiftUI

class ProfileFeedViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    
    @Published var user: UserModel?
    @Published var feeds: [FeedModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func getUser() {
        AuthApi().getMe()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] user in
                self?.isLoading = false
                self?.user = user
                print("유저 정보 가져오기 성공: \(user)")
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("유저 정보 가져오기 실패: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
    
    func getFeeds(userId: Int) {
        isLoading = true
        FeedApi().getFeeds(userId: userId)
            .subscribe { [weak self] response in
                self?.isLoading = false
                self?.feeds = response.data
                print("유저(\(userId)) 피드 가져오기 성공: \(String(describing: self?.feeds))")
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("유저(\(userId)) 피드 가져오기 실패: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
}
