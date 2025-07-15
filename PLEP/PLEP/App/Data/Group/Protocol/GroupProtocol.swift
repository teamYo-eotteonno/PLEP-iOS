//
//  GroupProtocol.swift
//  PLEP
//
//  Created by 이다경 on 7/15/25.
//

import Foundation
import RxSwift
import Alamofire

protocol GroupProtocol {
    func addGroup(body: GroupRequest) -> Single<GroupModel>
}
