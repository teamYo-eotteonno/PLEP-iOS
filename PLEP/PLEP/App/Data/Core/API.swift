//
//  API.swift
//  PLEP
//
//  Created by 이다경 on 7/5/25.
//

import Foundation
import Alamofire

class API {
    static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        let apiLogger = PLEPApiEventLogger()
        let interceptor = AuthInterceptor()
        return Session(configuration: configuration, interceptor: interceptor, eventMonitors: [apiLogger])
    }()
}
