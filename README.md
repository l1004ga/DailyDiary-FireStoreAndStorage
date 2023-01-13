# 나의 하루
### 생체인증을 통한 로그인, 매일의 기분에 따라 일기장 테마를 골라서 일기 작성하는 앱

# 사용된 기술
1. Firebase(Firebase Authentication, Storage, Store)
    - (참고자료) https://firebase.google.com/docs
    
2. Lottie Animation
    - 위쪽 자료를 메인으로 참고, 업데이트 버전에 없는 메서드가 있어서 해당 메서드만 아래 자료 참고로 수정함
    - (참고자료) https://velog.io/@lawn/iOS-SwiftUI-Lottie-%EC%99%84%EB%B2%BD-%EC%A0%95%EB%B3%B5-Lawn
    - (참고자료) https://blog.devgenius.io/boost-your-apps-user-experience-with-lottie-animations-and-swift-1f2b9572a74

3. PhotosUI
    - (참고자료) https://www.youtube.com/watch?v=Duh4Vdg6Z2E

4. 적용 고민중인 기술들
    -  키체인
    - NSCache 이미지 캐시처리 https://beenii.tistory.com/187

# 주요기능
1. 앱 로딩
    - 앱 로딩 뷰 및 로딩 배경음악(소리 HIG에 맞춰서 뚝딱 제작해주신 튜센세 감사합니다~)

2. 로그인
    - 기본 이메일 + 비밀번호 로그인
    - 생체인증 등록 시 생체인증 로그인 (구현중)
    
3. 회원가입
    - 이름, 이메일, 비밀번호, 비밀번호 입력 및 제출 시 Firebase Authentication 등록됨
      - 이메일 형식이 아닌 일반 아이디 작성 후 회원가입 시도 → 오류 알람 발생
      - 비밀번호를 6자리 미만으로 작성 후 회원가입 시도 → 오류 알람 발생
    - 생체인증 사용여부 확인 및 등록 시 비밀번호 재확인을 통한 승인

4. 테마선택
    - 5개의 일기장 테마(기쁨, 행복, 슬픔, 우울, 사랑) 선택 가능

5.테마별 일기장
    - 각 태마별로 작성된 일기를 모아보기 및 각 일기별 세부내용 이동 (구현중)
    - 각 테마별 일기작성하기 이동
    - 테마별 일기 등록 완료 시 자동으로 뷰 업데이트

6. 테마별 일기작성
    - 작성일 표시
    - 여러장 사진 등록 가능(최대 5개로 지정함, Firebase 부하를 조절하기 위해)
    - 일기 작성 및 등록

7. 마이페이지
    - 로그인 시 기본 로그인 방식(생체인증, 비밀번호) 선택 가능 (구현중)
    - 로그아웃 (구현중)

# 화면캡처
| <img width="200" src="https://user-images.githubusercontent.com/55937627/212257742-1fa9cb0b-8c6a-44d6-8820-f2ceda0a661a.png"> | <img width="200" src="https://user-images.githubusercontent.com/55937627/212257784-6f96c0d0-8c26-4d8a-9c14-86d4ef26c17a.png"> | <img width="200" src="https://user-images.githubusercontent.com/55937627/212257887-23d7888f-bb7b-426e-ab05-d46bc322cc4d.png"> |
|:-:|:-:|:-:|
| 로딩뷰 |	로그인뷰 | 회원가입뷰 |

| <img width="200" src="https://user-images.githubusercontent.com/55937627/212257929-2cd5b032-4653-481e-b6da-5d6ebe585fc5.png"> | <img width="200" src="https://user-images.githubusercontent.com/55937627/212257934-39a99d14-55a5-485d-8dd9-14a005ab7355.png"> | <img width="200" src="https://user-images.githubusercontent.com/55937627/212257949-ac6aa7ed-3791-4509-922c-17e9ef70bbf3.png"> | <img width="200" src="https://user-images.githubusercontent.com/55937627/212257968-18535cb3-229c-4cd0-a727-ff1d6f05fddd.png"> |
|:-:|:-:|:-:|:-:|
| 생체인증뷰 | 생체인증뷰	| 생체인증뷰	| 생체인증뷰 | 
		

| <img width="200" src="https://user-images.githubusercontent.com/55937627/212258051-a075a121-5a08-4d96-a3f3-c14f8bf48e12.png"> | <img width="200" src="https://user-images.githubusercontent.com/55937627/212258084-21ec1cda-66e7-4632-8400-ea68cbaa7e7b.png"> | <img width="200" src="https://user-images.githubusercontent.com/55937627/212258094-0168f277-faaf-4501-8cc3-1f640c166864.png"> |
|:-:|:-:|:-:|
| 테마선택뷰	| 일기내용뷰	| 일기내용뷰 | 


| <img width="200" src="https://user-images.githubusercontent.com/55937627/212258168-606c0f4a-2927-4d84-b670-a64612230840.png"> | <img width="200" src="https://user-images.githubusercontent.com/55937627/212258176-0863c194-4b00-4c29-9ae2-b710e9da477b.png"> | <img width="200" src="https://user-images.githubusercontent.com/55937627/212258184-23fd96ec-ed2b-4600-bf09-a2960bbd88c2.png"> |
|:-:|:-:|:-:|
| 일기작성뷰	| 일기작성뷰	| 일기내용뷰-업데이트 | 

# TODO 리스트!

    - 생체인증과 관련된 회원가입 로그인 프로세스 변경
    - 마이페이지(로그인방식 토글, 로그아웃 등) 구현
    - 일기내용 세부보기 구현
    - 로그인 시 세션 유지방식 고려(키체인!!!!)
    - 이메일 및 이름 입력 시 알맞는 키보드 세팅(완료)
    - 일기 작성 시 시간 데이터포맷 맞춰주기(완료)
    - Google Info-Plist 삭제
