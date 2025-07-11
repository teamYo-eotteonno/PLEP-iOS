//
//  FileApi.swift
//  PLEP
//
//  Created by 이다경 on 7/11/25.
//

import Foundation
import Alamofire
import RxSwift

class FileApi: FileProtocol {
    
    func uploadImage(imageData: Data, fileName: String, mimeType: String) -> Single<UploadResponse> {
        let url = URL(string: PLEPURL.Files.uploadFiles)!
        let headers: HTTPHeaders = ["Content-Type": "multipart/form-data"]
        
        return Single.create { single in
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageData, withName: "file", fileName: fileName, mimeType: mimeType)
                },
                to: url,
                method: .post,
                headers: headers
            )
            .validate()
            .responseDecodable(of: UploadResponse.self) { response in
                switch response.result {
                case .success(let model):
                    single(.success(model))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
