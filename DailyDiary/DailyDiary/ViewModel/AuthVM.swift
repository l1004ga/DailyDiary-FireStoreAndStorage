//
//  AuthVM.swift
//  DailyDiary
//
//  Created by dev on 2023/01/10.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseCore

class AuthVM : ObservableObject {
    
    // 로그인 상태 확인
    @Published var currentUser: Firebase.User?
    
    //앱 로그인에 따른 page 변경
    @Published var page = "Page1"
    
    //파이어베이스 접근 경로
    let db = Firestore.firestore()
    
    //로그인 후 저장되는 변수
    @Published var storeEmail : String?
    @Published var storeName : String?
    
    func registerUser(email: String, password: String, name : String,  completion: @escaping (Int, String) -> ()) async {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                let code = (error as NSError).code
                print("Error \(error.localizedDescription)")
                print(code)
                completion(code, "")
            }
            else {
                let uid = result?.user.uid
                completion(200, uid ?? "") //성공 번호
                self.userToStore(email: email, name: name)
            }
        }
    }
    
    
    //파이어베이스 기존 계정 확인 및 로그인
    func loginUser(email: String, password: String, completion : @escaping (Int) -> ()) async {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if let error = error {
                let code = (error as NSError).code
                print(code)
                print(error.localizedDescription)
                completion(code)
            } else {
                
                if let user = Auth.auth().currentUser {
                    print("Successfully logged in as user: \(result?.user.uid ?? "")")
                    self.currentUser = result?.user
                    self.fetchUser(email: email)
                    completion(200)
                }
                
            }
        }
    }
    
    //데이터베이스에 User 추가
    func userToStore(email : String, name : String) {
        //FireStore user컬렉션에 생성될 document의 key값으로 사용될 예정
        
        let userData = ["email" : email, "name": name] as [String : Any]
        
        Firestore.firestore().collection("users").document("\(email)").setData(userData as [String : Any]) { error in
            if let error = error {
                print(error)
                return
            }
            print("success")
        }
        
    }
    
    func fetchUser(email :String) {
        Firestore.firestore().collection("users").whereField("email", isEqualTo: email).getDocuments() { (snapshot, error) in
                
                if let snapshot {
                    for document in snapshot.documents {
                        
                        let docData = document.data()
                        let username: String = docData["name"] as? String ?? ""
                        
                        self.storeEmail = email
                        self.storeName = username
                        print(self.storeName)
                        
                    }
                }
            }
    }
    
    func logout() {
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
    
    
}
