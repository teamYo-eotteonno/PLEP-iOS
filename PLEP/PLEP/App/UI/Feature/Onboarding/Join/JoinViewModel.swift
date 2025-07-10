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
    private let disposeBag = DisposeBag()
    private let api: AuthProtocol
    
    init(api: AuthProtocol) {
        self.api = api
    }
    
    let joinData = BehaviorRelay<JoinData>(value: JoinData())
    
    @Published var emailCodeResult: EmptyResponse?
    @Published var errorMessage: String?
        
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
    
    func requestEmailCode() {
        let data = joinData.value
        let request = CodeRequest(email: data.email)
        
        let url = PLEPURL.Email.code
        print("➡️ [JoinViewModel] 이메일 코드 요청 시작: \(data.email)")
        print("🌐 [JoinViewModel] API Endpoint: \(url)")
        
        api.codeemail(body: request)
            .observe(on: MainScheduler.instance)
            .do(onSubscribe: {
                print("🔄 [JoinViewModel] 이메일 코드 요청 중...")
            })
            .subscribe(onSuccess: { [weak self] response in
                print("✅ [JoinViewModel] 이메일 코드 요청 성공")
                self?.emailCodeResult = response
            }, onFailure: { [weak self] error in
                print("❌ [JoinViewModel] 이메일 코드 요청 실패: \(error.localizedDescription)")
                self?.errorMessage = error.localizedDescription
            })
            .disposed(by: disposeBag)
    }
}
