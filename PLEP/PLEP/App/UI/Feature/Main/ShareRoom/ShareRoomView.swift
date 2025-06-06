//
//  ShaerRoomView.swift
//  PLEP
//
//  Created by 이다경 on 6/3/25.
//

import SwiftUI

struct ShareRoomView: View {
    @State private var showDeletePopup = false
    @State private var showMoreSheet = false
    @State private var showPDFSheet = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 10) {
                    ShareRoomTitle(
                        my: true,
                        title: "아포방포",
                        invite: {},
                        delete: { showDeletePopup = true },
                        more: { showMoreSheet = true }
                    )
                    ShareRoomBody(member: "민슈가")
                }
                .background(Color.g[100])
            }
            .ignoresSafeArea()
            .sheet(isPresented: $showMoreSheet) {
                ZStack {
                    Color.g[0]
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    
                    VStack(spacing: 0) {
                        Capsule()
                            .foregroundColor(.g[500])
                            .frame(width: 64, height: 1)
                            .padding(.vertical, 20)
                        
                        MoreSheet(onMember: {}, onRoom: {})
                        
                    }
                }
                .presentationDetents([.fraction(0.2)])
                .presentationDragIndicator(.hidden)
            }
            .sheet(isPresented: $showPDFSheet) {
                ZStack {
                    Color.g[0]
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    
                    VStack(spacing: 0) {
                        Capsule()
                            .foregroundColor(.g[500])
                            .frame(width: 64, height: 1)
                            .padding(.vertical, 20)
                        
                        SharingSheet()
                    }
                }
                .presentationDetents([.fraction(0.35)])
                .presentationDragIndicator(.hidden)
            }
            
            SubBottomSheet() {
                NumberingListSheet(num: 5, onPDF: { showPDFSheet.toggle() })
            }
            
            if showDeletePopup {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showDeletePopup = false
                    }
                
                ShareRoomDeletePopup(
                    onYes: {
                        showDeletePopup = false
                    },
                    onNo: {
                        showDeletePopup = false
                    }
                )
            }
        }
    }
}

#Preview {
    ShareRoomView()
}
