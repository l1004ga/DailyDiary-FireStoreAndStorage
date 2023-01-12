//
//  DiaryAddView.swift
//  DailyDiary
//
//  Created by dev on 2023/01/11.
//

import SwiftUI
import PhotosUI

struct DiaryAddView: View {
    
    @EnvironmentObject var diaryVM : DiaryVM
    @EnvironmentObject var authVM : AuthVM
    
    @State private var memo: String = ""
    @State var category : String
    
    
    //DiaryView에서 showingAddingSheet를 바인딩해서 받아옴
    @Binding var showingSheet: Bool
    
    //이미지 선택 시 사용되는 변수
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()        //UIImage is hashable
    
    var trimMemo: String {
        memo.trimmingCharacters(in: .whitespaces)
    }
    //현재 인스턴스를 해제하기 위해 사용
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    HStack{
                        Text("오늘의 일기")
                            .foregroundColor(.yellow)
                            .font(.custom("KyoboHandwriting2021sjy", size: 35))
                        Spacer()
                        Text(Date(), style: .date)
                            .foregroundColor(.yellow)
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                        
                    }.padding(.top)
                    
                    //PhotosUI 사용
                    VStack{
                        
                        //이미지만 선택할 수 있도록 정의함(matching 사용)
                        PhotosPicker(selection: $selectedItems,maxSelectionCount: 5, matching: .images) {
                            
                            if selectedImages.count > 0 {
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(selectedImages, id: \.self) { image in
                                            Image(uiImage: image)
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                        }
                                    }
                                }
                            } else {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray.opacity(0.6))
                                    .padding()
                            }
                            
                        }
                        .onChange(of: selectedItems) { newValue in
                            Task{
                                selectedImages = []
                                for value in newValue {
                                    if let imageData = try? await value.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                                        selectedImages.append(image)
                                    }
                                }
                            }
                        }
                    }
                    
                    ScrollView{
                        TextField("Memo", text: $memo, axis: .vertical)
                            .placeholder(when: memo.isEmpty) {
                                Text("여기에 일기를 써보자!").foregroundColor(.gray)
                            }
                            .accentColor(.yellow)
                            .foregroundColor(.white)
                            .font(.custom("KyoboHandwriting2021sjy", size: 20))
                            .padding(.top, 30)
                        
                    }
                    
                    
                }.padding(40)
                    .background(Color("MainColor"))
                
                Button {
                    Task{
                        var count = 0
                        let uid = UUID().uuidString
                        for value in selectedImages{
                            await diaryVM.storeImageToStorage(image: value, memo: memo, user: authVM.storeName!, email: authVM.storeEmail!, diaryID: uid, category: category)
                        }
                    }
                    dismiss()

                } label: {
                    Text("일기 저장하기")
                        .padding()
                        .frame(width: 350)
                        .background(.yellow)
                        .font(.custom("KyoboHandwriting2021sjy", size: 20))
                        .cornerRadius(15)
                        .foregroundColor(Color("MainColor"))
                }.padding(.top, 30)
                    .offset(y:300)
                
                Button {
                    dismiss()
                } label: {
                    Text("뒤로가기")
                        .foregroundColor(.white)
                        .font(.custom("KyoboHandwriting2021sjy", size: 20))
                }.offset(y:370)
            }
            
        }.background(Color("MainColor"))
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}


struct DiaryAddView_Previews: PreviewProvider {
    
    @State static var showingSheet = false
    
    static var previews: some View {
        DiaryAddView(category: "행복", showingSheet: $showingSheet)
            .environmentObject(AuthVM())
            .environmentObject(DiaryVM())
    }
}
