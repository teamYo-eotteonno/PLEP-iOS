//
//  JoinViewDi.swift
//  PLEP
//
//  Created by 이다경 on 7/9/25.
//

import Foundation
import SwiftUI

final class JoinViewDi {
    private let joinViewModel = JoinViewModel(api: AuthApi())
    
    func firstView(joinViewDi: JoinViewDi) -> some View {
        JoinFirstView(viewModel: joinViewModel, joinViewDi: joinViewDi)
    }
    
    func secondView(joinViewDi: JoinViewDi) -> some View {
        JoinSecondView(viewModel: joinViewModel, joinViewDi: joinViewDi)
    }
    
    func thirdView(joinViewDi: JoinViewDi) -> some View {
        JoinThirdView(viewModel: joinViewModel, joinViewDi: joinViewDi)
    }
    
    func fifthView(joinViewDi: JoinViewDi) -> some View {
        JoinFifthView(viewModel: joinViewModel, joinViewDi: joinViewDi)
    }
}
