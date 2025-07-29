//
//  FileModel.swift
//  PLEP
//
//  Created by 이다경 on 7/11/25.
//

import Foundation

struct UploadResponse: Decodable {
    let file: FileModel
}

struct FileModel: Decodable, Equatable {
    let id: String
    let path: String
}
