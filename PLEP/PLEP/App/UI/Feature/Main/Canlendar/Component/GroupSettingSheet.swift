//
//  GroupSettingSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/10/25.
//

import SwiftUI

enum GroupSettingSheetType {
    case can, cant, more
}

struct GroupSettingSheet: View {
    var groupIndex: Int?
    let type: GroupSettingSheetType
    @State private var groupName: String
    @State private var selectedColor: Color?
    var color: Color?
    var title: String?
    var onDelete: (() -> Void)?
    var onEdit: (() -> Void)?
    var onComplete: ((String, Color) -> Void)?
    
    var groupNameInitial: String = ""
    var selectedColorInitial: Color = .file.red
    
    init(
        groupIndex: Int? = nil,
        type: GroupSettingSheetType,
        groupNameInitial: String = "",
        selectedColorInitial: Color = .file.red,
        onComplete: ((String, Color) -> Void)? = nil,
        onEdit: (() -> Void)? = nil
    ) {
        self.groupIndex = groupIndex
        self.type = type
        self._groupName = State(initialValue: groupNameInitial)
        self._selectedColor = State(initialValue: selectedColorInitial)
        self.onComplete = onComplete
        self.onEdit = onEdit
    }
    
    var body: some View {
        VStack(spacing: 17) {
            Text("그룹 설정")
                .textStyle.body.bold
                .foregroundColor(.txt.primary)
            PLEPDivider(type: .g200)
            switch type {
            case.can:
                VStack(spacing: 55) {
                    VStack(spacing: 25) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("그룹명")
                                .textStyle.body.default
                                .foregroundColor(.txt.primary)
                            PLEPTextField(
                                text: $groupName,
                                placeholder: "그룹명을 설정해주세요",
                                errorMessage: "그룹명을 설정해주세요"
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("색선택")
                                .textStyle.body.default
                                .foregroundColor(.txt.primary)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                HStack(spacing: 5) {
                                    GroupColorCell(color: .file.red, isSelected: selectedColor == .file.red) {
                                        selectedColor = .file.red
                                    }
                                    GroupColorCell(color: .file.orange, isSelected: selectedColor == .file.orange) {
                                        selectedColor = .file.orange
                                    }
                                    GroupColorCell(color: .file.yellow, isSelected: selectedColor == .file.yellow) {
                                        selectedColor = .file.yellow
                                    }
                                    GroupColorCell(color: .file.lame, isSelected: selectedColor == .file.lame) {
                                        selectedColor = .file.lame
                                    }
                                    GroupColorCell(color: .file.green, isSelected: selectedColor == .file.green) {
                                        selectedColor = .file.green
                                    }
                                    GroupColorCell(color: .file.sky, isSelected: selectedColor == .file.sky) {
                                        selectedColor = .file.sky
                                    }
                                    GroupColorCell(color: .file.blue, isSelected: selectedColor == .file.blue) {
                                        selectedColor = .file.blue
                                    }
                                }
                                HStack(spacing: 5) {
                                    GroupColorCell(color: .file.purple, isSelected: selectedColor == .file.purple) {
                                        selectedColor = .file.purple
                                    }
                                    GroupColorCell(color: .file.magenta, isSelected: selectedColor == .file.magenta) {
                                        selectedColor = .file.magenta
                                    }
                                    GroupColorCell(color: .file.pink, isSelected: selectedColor == .file.pink) {
                                        selectedColor = .file.pink
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    PLEPButton(
                        title: "설정완료",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        action: {
                            if let selectedColor = selectedColor, !groupName.isEmpty {
                                onComplete?(groupName, selectedColor)
                            }
                        }
                    )
                }
            case.cant:
                VStack(spacing: 10) {
                    Image(Asset.Folder.no)
                        .resizable()
                        .frame(width: 70, height: 70)
                    Text("현재 존재하는 그룹이 너무 많아\n그룹을 생성하실 수 없습니다!")
                        .textStyle.title.pre
                        .foregroundColor(.txt.tertiary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 45)
                .background(Color.g[50])
                .cornerRadius(15)
            case.more:
                HStack(spacing: 17) {
                    HStack(spacing: 13) {
                        Rectangle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(selectedColor)
                            .cornerRadius(5)
                        Text(groupName)
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                    }
                    .frame(maxWidth: 180, alignment: .leading)
                    HStack(spacing: 10) {
                        PLEPButton(
                            title: "삭제",
                            type: .neutral,
                            size: .small,
                            enabled: true,
                            action: onDelete ?? {}
                        )
                        
                        PLEPButton(
                            title: "수정",
                            type: .outlined,
                            size: .small,
                            enabled: true,
                            action: onEdit ?? {}
                        )
                    }
                }
            }
        }
        .padding(.bottom, 45)
        .padding(.horizontal, 25)
        .background(Color.g[0])
    }
}

struct GroupColorCell: View {
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Rectangle()
                .frame(width: 40, height: 40)
                .foregroundStyle(color)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isSelected ? Color.black : Color.clear, lineWidth: 3)
                )
        }
    }
}
