//
//  JoinFourthView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI
import FlowKit
import PhotosUI

struct JoinFourthView: View {
    @Flow var flow
    @State private var randomType: ProfileCellType = .way
    @State private var selectedImage: UIImage?
    @State private var photoItem: PhotosPickerItem?

    @StateObject var viewModel: JoinViewModel
    var joinViewDi: JoinViewDi

    @State private var showPicker = false

    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .default, action: { flow.pop() }, showLine: false)

                VStack(alignment: .leading) {
                    Text("프로필을 설정해주세요.")
                        .textStyle.title.header3
                        .foregroundColor(.txt.primary)
                        .padding(.bottom, 1)

                    Text("(후에 수정이 가능한 항목입니다.)")
                        .textStyle.body.default
                        .foregroundColor(.txt.primary)

                    Spacer()

                    HStack {
                        Spacer()
                        ProfileCell(
                            type: randomType == .custom ? .custom : randomType,
                            size: .large,
                            btn: true,
                            onButtonTap: {
                                showPicker = true
                            },
                            image: $selectedImage
                        )
                        Spacer()
                    }

                    Spacer()

                    PLEPButton(
                        title: "넘어가기",
                        type: .neutral,
                        size: .medium,
                        enabled: true
                    ) {
                        viewModel.updateDefaultPhoto(photo: "default/path", type: randomType)
                        flow.push(joinViewDi.fifthView(joinViewDi: joinViewDi))
                    }
                    .padding(.bottom, 65)
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
        .navigationBarHidden(true)
        .photosPicker(isPresented: $showPicker, selection: $photoItem, matching: .images)
        .onChange(of: photoItem) { newItem in
            if let item = newItem {
                print("[JoinFourthView] PhotosPicker 아이템 선택됨")
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data, let uiImage = UIImage(data: data) {
                            print("[JoinFourthView] 이미지 변환 성공, 업로드 시작")
                            selectedImage = uiImage
                            randomType = .custom
                            viewModel.uploadImage(image: uiImage)
                        } else {
                            print("[JoinFourthView] 이미지 변환 실패: Data → UIImage 변환 실패")
                        }
                    case .failure(let error):
                        print("[JoinFourthView] 이미지 로드 실패: \(error.localizedDescription)")
                    }
                }
            } else {
                print("[JoinFourthView] PhotosPicker 아이템이 nil임")
            }
        }
    }
}
