//
//  JoinViewModel.swift
//  PLEP
//
//  Created by 이다경 on 7/9/25.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class JoinViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    private let api: AuthProtocol
    private let fileApi: FileProtocol
    
    init(api: AuthProtocol, fileApi: FileProtocol) {
        self.api = api
        self.fileApi = fileApi
    }
    
    let joinData = BehaviorRelay<JoinData>(value: JoinData())
    
    @Published var emailCodeResult: EmptyResponse?
    @Published var errorMessage: String?
    @Published var joinResult: Bool? = nil
    
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
    
    func updatePhoto(_ photo: String?) {
        var data = joinData.value
        data.photo = photo!
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
        print("이메일 코드 요청 시작: \(data.email)")
        print("API Endpoint: \(url)")
        
        api.codeemail(body: request)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                print("이메일 코드 요청 성공")
                self?.emailCodeResult = response
            }, onFailure: { [weak self] error in
                print("이메일 코드 요청 실패: \(error.localizedDescription)")
                self?.errorMessage = error.localizedDescription
            })
            .disposed(by: disposeBag)
    }
    
    func uploadImage(image: UIImage) {
        print("[JoinViewModel] 프로필 이미지 업로드 시작")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            self.errorMessage = "이미지 변환 실패"
            print("[JoinViewModel] 이미지 jpeg 변환 실패")
            return
        }
        
        fileApi.uploadImage(imageData: imageData, fileName: "profile.jpg", mimeType: "image/jpeg")
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                print("[JoinViewModel] 이미지 업로드 성공")
                print("[JoinViewModel] 반환된 파일 ID: \(response.file.id)")
                print("[JoinViewModel] 파일 경로: \(response.file.path)")
                self?.updatePhoto(response.file.id)
            }, onFailure: { [weak self] error in
                print("[JoinViewModel] 이미지 업로드 실패: \(error.localizedDescription)")
                self?.errorMessage = error.localizedDescription
            })
            .disposed(by: disposeBag)
    }
    
    func join(email: String, password: String, name: String, bio: String, code: Int, photo: String?) {
        self.errorMessage = nil
        
        let body = JoinRequest(
            email: email,
            password: password,
            name: name,
            bio: bio,
            code: String(code),
            photo: photo != nil ? JoinPhotoId(id: photo!) : nil
        )
        
        api.join(body: body)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                print("회원가입 성공")
                self?.emailCodeResult = response
                self?.joinResult = true
            }, onFailure: { [weak self] error in
                print("회원가입 실패: \(error.localizedDescription)")
                self?.errorMessage = error.localizedDescription
                self?.joinResult = false
            })
            .disposed(by: disposeBag)
    }
}
