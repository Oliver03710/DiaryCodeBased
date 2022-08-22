//
//  RealmModel.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/22.
//

import Foundation
import RealmSwift

// UserDiary: 테이블 이름
// @Persisted: 컬럼
class UserDiary: Object {
    @Persisted var diaryTitle: String   // 제목(필수)
    @Persisted var contents: String?    // 내용(옵션)
    @Persisted var writingDate = Date()    // 작성날짜(필수)
    @Persisted var registerDate = Date()    // 등록날짜(필수)
    @Persisted var favourite: Bool    // 즐겨찾기(필수)
    @Persisted var photos: String?    // 사진String(옵션)
    
    // PK(필수): Int, String(랜덤 돌리기 힘듦), UUID(✓), ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(diaryTitle: String, contents: String?, writingDate: Date, registerDate: Date, photos: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.contents = contents
        self.writingDate = writingDate
        self.registerDate = registerDate
        self.photos = photos
        self.favourite = false
        }
    
}
