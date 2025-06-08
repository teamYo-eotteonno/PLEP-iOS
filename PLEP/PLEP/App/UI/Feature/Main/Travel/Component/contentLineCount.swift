//
//  contentLineCount.swift
//  PLEP
//
//  Created by 이다경 on 6/9/25.
//

import SwiftUI

func contentLineCount(_ content: String) -> Int {
    let approxCharsPerLine = 40 // 글자 크기와 너비에 따라 조절
    return (content.count / approxCharsPerLine) + 1
}
