//
//  MainCalendarViewModel.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import RxSwift
import Combine
import SwiftUI

class MainCalendarViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    
    @Published var group: GroupModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var groups: [GroupModel]?
    
    private let groupApi: GroupApi
    
    init(api: GroupApi) {
        self.groupApi = api
    }
    
    func addGroup(body: GroupRequest, completion: @escaping (Result<GroupModel, Error>) -> Void) {
        isLoading = true
        groupApi.addGroup(body: body)
            .subscribe { [weak self] group in
                self?.isLoading = false
                print("그룹 추가 성공: \(group)")
                self?.getGroups()
                completion(.success(group))
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("그룹 추가 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
            .disposed(by: disposeBag)
    }
    
    func getGroups() {
        isLoading = true
        groupApi.getGroups()
            .subscribe { [weak self] groups in
                self?.isLoading = false
                self?.groups = groups
                print("그룹 목록 가져오기 성공: \(groups)")
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("그룹 목록 가져오기 실패: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
    
    func editGroup(body: GroupRequest, id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        
        groupApi.editGroup(body: body, id: id)
            .subscribe { [weak self] _ in
                self?.isLoading = false
                print("그룹 수정 성공 (id: \(id))")
                self?.getGroups()
                completion(.success(()))
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("그룹 수정 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
            .disposed(by: disposeBag)
    }
    
    func deleteGroup(id: Int) {
        isLoading = true
        groupApi.deleteGroup(id: id)
            .subscribe { [weak self] _ in
                self?.isLoading = false
                print("그룹 삭제 성공 (id: \(id))")
                self?.getGroups()
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("그룹 삭제 실패: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
}
