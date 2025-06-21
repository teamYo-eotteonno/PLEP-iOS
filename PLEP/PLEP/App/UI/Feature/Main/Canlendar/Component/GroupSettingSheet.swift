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
    @State private var groupName = ""
    var color: Color?
    var title: String?
    var onDelete: (() -> Void)?
    var onEdit: (() -> Void)?
    
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
                                    GroupColorCell(.file.red)
                                    GroupColorCell(.file.orange)
                                    GroupColorCell(.file.yellow)
                                    GroupColorCell(.file.lame)
                                    GroupColorCell(.file.green)
                                    GroupColorCell(.file.sky)
                                    GroupColorCell(.file.blue)
                                }
                                HStack(spacing: 5) {
                                    GroupColorCell(.file.purple)
                                    GroupColorCell(.file.magenta)
                                    GroupColorCell(.file.pink)
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
                        action: {}
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
                            .foregroundColor(color)
                            .cornerRadius(5)
                        Text(title!)
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
                            action: onDelete!
                        )
                        
                        PLEPButton(
                            title: "수정",
                            type: .outlined,
                            size: .small,
                            enabled: true,
                            action: onEdit!
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
    let action: () -> Void
    
    init(_ color: Color) {
        self.color = color
        self.action = {}
    }

    var body: some View {
        Button(action: action) {
            Rectangle()
                .frame(width: 40, height: 40)
                .foregroundStyle(color)
                .cornerRadius(5)
        }
    }
}
