//
//  DiaryModels.swift
//  DailyDiary
//
//  Created by dev on 2023/01/11.
//

import Foundation
import SwiftUI

struct Diary: Codable, Identifiable, Hashable {
    let id: String
    let username: String
    let memo: String
    //날짜 생성
    let createdAt: Date
    //날짜 포맷 후 뷰에 사용될 데이터 형식
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일" // "yyyy-MM-dd HH:mm:ss"
        
        let dateCreatedAt = createdAt
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    let images: [String]
    let category : String
}

