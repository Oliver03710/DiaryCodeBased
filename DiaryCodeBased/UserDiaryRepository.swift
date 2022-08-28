//
//  UserDiaryRepository.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/26.
//

import Foundation

import RealmSwift

protocol UserDiaryRepositoryType {
    func fetch() -> Results<UserDiary>
    func fetchSort(_ sortedBy: String) -> Results<UserDiary>
    func fetchFilter() -> Results<UserDiary>
    func fetchDate(date: Date) -> Results<UserDiary>
    func updateFavourite(item: UserDiary)
    func deleteItem(item: UserDiary)
    func addItem(item: UserDiary)
}

// Realm이 복잡해지면 Extension UserDiaryRepository 등을 활용하여 기능 더 분리 가능
class UserDiaryRepository: UserDiaryRepositoryType {
    
    let localRealm = try! Realm()
    
    func addItem(item: UserDiary) {
        
        do {
            try localRealm.write { localRealm.add(item) }
        } catch let error { print(error) }
        
    }
    
    func fetchDate(date: Date) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("writingDate >= %@ AND writingDate < %@", date, Date(timeInterval: 86400, since: date))     // NSPredicate
    }
    
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "writingDate", ascending: false)
    }
    
    func fetchSort(_ sortedBy: String) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: sortedBy, ascending: true)
    }
    
    func fetchFilter() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "registerDate", ascending: true).filter("diaryTitle CONTAINS[c] 'a'")
    }
    
    func updateFavourite(item: UserDiary) {
        
        // Realm data update

            try! localRealm.write {
            // 하나의 레코드에서 특정 컬럼 하나만 변경
                
                item.favourite.toggle()
            
            // 하나의 테이블에 특정 컬럼 전체를 변경
//                self.tasks.setValue(true, forKey: "favourite")
            
            // 하나의 레코드에서 여러 컬럼들이 변경
//                self.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectId, "contents": "변경 테스트", "diaryTitle": "제목 변경"], update: .modified)
            
                print("Realm Update Succeed, reloadRows 필요")
        
        // 1. 스와이프한 셀 하나만 ReloadRows 코드 구현 -> 상대적 효율성
        // 2. 데이터가 변경되었으니 다시 Realm에서 데이터 가지고 오기 -> didSet으로 일관적 형태로 갱신
        
       
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func deleteItem(item: UserDiary) {
        
        do {
            try localRealm.write { localRealm.delete(item) }
        } catch let error { print(error) }
        removeImageFromDocument(fileName: "\(item.objectId).jpg")
        
    }
    
}
