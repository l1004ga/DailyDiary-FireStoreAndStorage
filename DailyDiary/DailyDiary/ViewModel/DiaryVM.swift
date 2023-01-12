//
//  DiaryVM.swift
//  DailyDiary
//
//  Created by dev on 2023/01/11.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class DiaryVM: ObservableObject {
    @Published var diarys: [Diary] = []
    @Published var postImages : [String] = []
    @Published var postImageUrls : UIImage?
    
    @EnvironmentObject var authVM : AuthVM
    
    let database = Firestore.firestore()
    
    init() {
        /*
         postits = [
         Postit(id: UUID().uuidString, username: "ned", memo: "Good morning", colorIndex: 0, createdAt: Date().timeIntervalSince1970),
         Postit(id: UUID().uuidString, username: "ned", memo: "Good evening", colorIndex: 1, createdAt: Date().timeIntervalSince1970),
         Postit(id: UUID().uuidString, username: "ned", memo: "Hello World", colorIndex: 2, createdAt: Date().timeIntervalSince1970),
         Postit(id: UUID().uuidString, username: "ned", memo: "Hello my friend", colorIndex: 3, createdAt: Date().timeIntervalSince1970)
         ]
         */
        diarys = []
    }
    
    //    var samplePostit: Diary {
    //        Diary(id: UUID().uuidString, username: "ned", memo: "Good morning",createdAt: Date().timeIntervalSince1970)
    //    }
    //    
    
    func fetchPostits(email :String) {
        database.collection("users").document("\(email)").collection("diarys")
            .getDocuments { (snapshot, error) in
                self.diarys.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                        let id: String = document.documentID
                        
                        let docData = document.data()
                        let username: String = docData["username"] as? String ?? ""
                        let memo: String = docData["memo"] as? String ?? ""
                        let images: [String] = docData["images"] as? [String] ?? []
                        //파이어베이스에 Timestamp 형식으로 저장된 데이터를 받아옴
                        let createdAtTimeStamp: Timestamp = docData["CreatedAt"] as? Timestamp ?? Timestamp()
                        //Timestamp로 받아온 데이터를 Date 형식으로 반환
                        let createdAt: Date = createdAtTimeStamp.dateValue()
                    
                        let category: String = docData["category"] as? String ?? ""
                        
                        let diary : Diary = Diary(id: id, username: username, memo: memo, createdAt: createdAt, images: images, category: category)
                        
                        self.diarys.append(diary)
                    }
                }
            }
    }
    
    func addDiary(_ diary: Diary, email : String, diaryID : String) {
        
        let timestampFormat : Timestamp = Timestamp(date: diary.createdAt)
        
        database.collection("users").document("\(email)").collection("diarys")
            .document("\(diaryID)")
            .setData(["username": diary.username,
                      "memo": diary.memo,
                      //TimeStamp 형식으로 들어가야 함
                      "createdAt": timestampFormat,
                      "images" : diary.images,
                      "category" : diary.category
                     ])
        
        fetchPostits(email : email)
    }
    
    //이미지를 Firebase Storage에 저장한다
    func storeImageToStorage(image : UIImage, memo : String, user : String, email : String, diaryID : String, category : String) async {
        let uid = diaryID
        let ref = Storage.storage().reference(withPath: uid)
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        let result = try await ref.putData(imageData) { metadata, error in
            
            ref.downloadURL() { [self] url, error in
                if let error = error {
                    print(error)
                    return
                }
                print(url?.absoluteString ?? "망함")
                
                guard let url = url else { return }
                print("데이터 다운로드 성공1 \(url)")
                
                
                self.postImages.append(url.absoluteString)
                print("전체 url 리스트 \(self.postImages)")
                self.addDiary(Diary(id: UUID().uuidString, username: user, memo: memo, createdAt: Date(), images: postImages, category: category), email: email, diaryID: uid)
            }
        }
    }
    
    
    //    func removePostit(_ diary: Diary) {
    //        database.collection("diarys")
    //            .document(diary.id).delete()
    //        fetchPostits()
    //    }
}
