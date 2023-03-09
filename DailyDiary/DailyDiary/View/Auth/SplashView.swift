//
//  SplashView.swift
//  DailyDiary
//
//  Created by dev on 2023/01/10.
//

import SwiftUI
import AVFoundation
import AVKit

class SoundSetting: ObservableObject {
    
    static let instance = SoundSetting()
    
    var player: AVAudioPlayer?
    init() {
        guard let url =  Bundle.main.url(forResource: "onelharu", withExtension: ".m4a") else { return }
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print("할당 에러. \(error.localizedDescription)")
        }

    }
    func playSound() {
           do {
               
               player?.stop()
               player?.currentTime = 0
               player?.prepareToPlay()
               player?.play()
               print("재생완료")
           } catch let error {
               print("재생하는데 오류가 발생했습니다. \(error.localizedDescription)")
           }
       }
 
}

struct SplashView: View {
    @State private var isActive = false
    @EnvironmentObject var authVM : AuthVM
    
    //효과음 넣기
    var soundSetting = SoundSetting()
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            
            ZStack{
                Color("MainColor").ignoresSafeArea()
                
                LottieView(jsonName: "38319-shining-stars")
                
                VStack{
                    Image("MainLogo").resizable().frame(width: 180, height: 180)
                        .padding(.bottom)
                    Text("나의 하루")
                        .font(.custom("KyoboHandwriting2021sjy", size: 35))
                        .foregroundColor(.white)

                }
            }
            .onAppear {
                SoundSetting.instance.playSound()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }

}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
