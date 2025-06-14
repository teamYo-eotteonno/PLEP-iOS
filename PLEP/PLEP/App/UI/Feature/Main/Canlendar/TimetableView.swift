//
//  TimetableView.swift
//  PLEP
//
//  Created by 이다경 on 6/14/25.
//

import SwiftUI

struct TimetableView: View {
    let title: String
    
    @State private var showTimetable = false
    @State private var showAddSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            PLEPTopbar(type: .text(title), action: {})
            ScrollView {
                VStack(spacing: 23) {
                    ForEach(0..<3) { _ in
                        TimetableList(
                            null: false,
                            onInformation: {
                                showTimetable.toggle()
                            },
                            onAdd: {
                                showAddSheet.toggle()
                            }
                        )
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 23)
            }
            .background(Color.g[50])
            .sheet(isPresented: $showTimetable) {
                ZStack {
                    Color.g[0]
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    
                    VStack(spacing: 0) {
                        Capsule()
                            .foregroundColor(.g[500])
                            .frame(width: 64, height: 1)
                            .padding(.vertical, 20)
                        
                        TimetableSheet(
                            place: "방탄소년단",
                            time: "400",
                            address: "빅히트본사",
                            note: "방탄이 12주년을 맞아 페스타를 열었습니다."
                        )
                    }
                }
                .presentationDetents([.fraction(0.483)])
                .presentationDragIndicator(.hidden)
            }
            .sheet(isPresented: $showAddSheet) {
                VStack(spacing: 0) {
                        Capsule()
                            .foregroundColor(.g[500])
                            .frame(width: 64, height: 1)
                            .padding(.vertical, 20)

                        TimetableAddSheet()
                    }
                    .background(Color.g[0])
                    .cornerRadius(20)
                    .presentationDetents([.fraction(0.9)])
                    .presentationDragIndicator(.hidden)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TimetableView(title: "방탄소년단 12주년 탐방")
}
