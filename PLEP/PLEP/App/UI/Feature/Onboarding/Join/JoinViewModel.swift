//
//  JoinViewModel.swift
//  PLEP
//
//  Created by 이다경 on 7/9/25.
//

import Foundation
import RxSwift
import RxCocoa

class JoinViewModel: ObservableObject {
//    @Published var isLoading = false
//    @Published var loginResult: LoginModel?
//    @Published var errorMessage: String?

    private let disposeBag = DisposeBag()
    private let api: AuthProtocol

    init(api: AuthProtocol) {
        self.api = api
    }
    
    // BehaviorRelay로 현재 입력값을 저장
    let joinData = BehaviorRelay<JoinData>(value: JoinData())
    
    func updateName(_ name: String) {
        var data = joinData.value
        data.name = name
        joinData.accept(data)
    }
    
    func updatePass(_ pass: String) {
        var data = joinData.value
        data.pass = pass
        joinData.accept(data)
    }
    
    func updateEmail(_ email: String) {
        var data = joinData.value
        data.email = email
        joinData.accept(data)
    }
    
    func updateCode(_ code: Int) {
        var data = joinData.value
        data.code = code
        joinData.accept(data)
    }
    
    func updateIntro(_ intro: String) {
        var data = joinData.value
        data.intro = intro
        joinData.accept(data)
    }
}
