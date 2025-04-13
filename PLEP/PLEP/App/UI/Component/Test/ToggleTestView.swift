//
//  ToggleTestView.swift
//  PLEP
//
//  Created by 이다경 on 4/13/25.
//

import SwiftUI

struct ToggleTestView: View {
    
    @State var toggles: [[Bool]] = Array(
        repeating: Array(repeating: false, count: PLEPToggleColor.allCases.count),
        count: PLEPToggleType.allCases.count
    )

    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(PLEPToggleType.allCases.indices, id: \.self) { typeIndex in
                ForEach(PLEPToggleColor.allCases.indices, id: \.self) { colorIndex in
                    let type = PLEPToggleType.allCases[typeIndex]
                    let color = PLEPToggleColor.allCases[colorIndex]
                    
                    PLEPToggle(
                        type: type,
                        enabled: toggles[typeIndex][colorIndex],
                        color: color,
                        action: {
                            toggles[typeIndex][colorIndex].toggle()
                        }
                    )
                }
            }
            
        }
    }
}

#Preview {
    ToggleTestView()
}
