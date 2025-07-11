//
//  FileProtocol.swift
//  PLEP
//
//  Created by 이다경 on 7/11/25.
//

import Foundation
import RxSwift
import Alamofire

protocol FileProtocol {
    func uploadImage(imageData: Data, fileName: String, mimeType: String) -> Single<UploadResponse>
}
