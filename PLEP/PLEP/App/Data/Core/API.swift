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
        return Session(configuration: configuration, eventMonitors: [apiLogger])
    }()
}
