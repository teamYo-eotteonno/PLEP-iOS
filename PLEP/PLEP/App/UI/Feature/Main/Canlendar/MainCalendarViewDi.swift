//
//  MainCalendarViewDi.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation
import SwiftUI

struct MainCalendarViewDi {
    var maincalendarView: some View {
        MainCalendarView(viewModel: maincalendarViewModel)
    }

    private var maincalendarViewModel: MainCalendarViewModel {
        MainCalendarViewModel(api: GroupApi())
    }
}
