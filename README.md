# Preview


![Tab1](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/5ccce211-4b9c-4ce8-a505-46e4339ad205/tab2-4.png)

Tab1

![Tab2](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/00358809-35d6-4686-8458-53e1cc4bb361/tab2.png)

Tab2

![Tab3](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/c869e89e-237c-4fb6-9724-31d5c6816075/tab3.png)

Tab3

# Team


[ 정인호](https://www.notion.so/f51fae3248a747fcb3100942d2a666f9?pvs=21)

[inho9899 - Overview](https://github.com/inho9899)

BackEnd Master (호소인)

[신지원](https://www.notion.so/26ddcb3aab754914b7de5f6e740523dd?pvs=21) 



[jiwonnee - Overview](https://github.com/jiwonnee)



FrontEnd Master (호소인)

# Tech Stack



- **Front-end** : Flutter
- **Back-end**: Node.js
- **Database**: MySQL
- **Server**: KCloud
- **IDE**: Android Studio & Vscode
- **Design**: Figma
- **SDK**: Kakao, Naver

# DB


![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/7f244e0d-f656-4f30-9369-3f260680643e/Untitled.png)

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/289a5934-c0d2-4534-aa70-c4b862d61b60/Untitled.png)

# Details
### 📱 기능 설명

### 로그인 화면

![일반로그인](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/6a692410-f651-47b8-86de-b79863fcf4c5/generallogin.gif)

일반로그인

![네이버 로그인 → 회원정보 입력](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/87d8ae07-08ab-4b0c-82b0-904576cdcab4/start1.gif)

네이버 로그인 → 회원정보 입력

![네이버 재로그인 → 홈스크린 연결](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/b72e6d8d-53db-4db6-a355-671f836b4c04/restart.gif)

네이버 재로그인 → 홈스크린 연결

- 카카오톡, 네이버 2가지의 간편 로그인 기능
    - 초기 1회 로그인 시에만 이름, 아이디, 패스워드 입력 페이지, 음악 취향 조사 페이지 나옴
    - 그 다음 로그인 부터는 버튼 하나로 바로 로그인 가능
- 일반 로그인
    - 간편 로그인이 아닌 아이디, 비밀번호를 입력 하여 로그인 하는 기능
    - 정보가 없는 사용자는 하단에 로그인 불가 메세지 나옴
- 회원가입
    - 이름, 아이디, 비밀번호를 입력하여 초기 사용자는 회원 가입 가능
    - 정보 입력 후, 음악 취향 조사 페이지 나옴
- 음악 취향 조사 페이지
    - 로그인 수단(일반, 간편 로그인)에 상관 없이 최초의 회원가입 진행 시 사용자의 음악 취향 조사 진행
    - 6개의 장르 중 1개 이상을 고르면 회원가입 완료 가능 → 추후에 Tab2의 음악 추천 기능을 위한 알고리즘에 정보 전달

### **Tab** 1️⃣ : **전체적인 일정 관리 기능**

![Tab1 출석체크](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/5b8d5a6c-10f3-481b-bd6b-ce5fe858ddb8/Tab1-1.gif)

Tab1 출석체크

- 출석 체크 기능
    - 출석 체크로 얻은 포인트로 Tab3의 이벤트에 참여 가능
    - 캘린더에 출석 체크한 날짜 바로 반영되어 표시
    - 하루에 한 번만 출석 가능하고, 버튼을 두번 클릭 시 하단에 경고 문구 나옴
    
- 예정된 활동
    - 포인트를 사용해서 참여하게 된 이벤트 리스트업
    
- 나의 리뷰
    - Tab2 에서 추천받은 음악에 대해 별점으로 평가 한 기록 리스트업
    - 앨범 표지, 가수, 제목 정보 표시
    


### **Tab** 2️⃣ : **사용자의 데이터에 기반한 음악 추천 기능**

![Tab2 플레이리스트에 추가
         & 플레이리스트 검색 ](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/43b1ecc2-959c-4ed3-b100-5a91fc97fe65/Tab2-1.gif)

Tab2 플레이리스트에 추가
         & 플레이리스트 검색 

 

![Tab2 리뷰쓰기 & 나의 리뷰에 추가](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/ccafc5ea-2b4d-4ff0-a8ec-fe02498c71cc/Tab2-2.gif)

Tab2 리뷰쓰기 & 나의 리뷰에 추가

![Tab2 음악 재생](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/089b2113-9d21-4cb1-8cde-295d09aed8f8/Tab2-3.gif)

Tab2 음악 재생

- 음악 추천 기능
    - 회원가입 시 진행했던 음악 취향 조사 탭 결과를 기반으로 추천 알고리즘 생성(Matrix initialization)
        - MF 알고리즘 적용, 매일 user에게 데이터 한 쌍(음악, 별점)을 제공받고 자체학습 진행
        
        ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/a7695add-f805-48fb-a6df-fec86524e001/Untitled.png)
        
    

    
    - 총 6개의 음악 장르를 기반으로 매일 1곡씩 추천 음악 제공
    - 앨범 표지 + 제목 + 아티스트명 정보를 제공
    - 음악 재생 및 중단, 원하는 부분으로 직접 이동하여 듣기 가능

- 리뷰 기능
    - 화면 왼쪽 상단의 이모티콘을 누르면 별점으로 리뷰 작성 가능
    - 리뷰를 저장하면 하단에 저장완료 문구 나옴
    - 리뷰 결과는 Tab1의 ‘나의 리뷰’ 부분에 즉시 반영
    - 리뷰 결과를 토대로 사용자의 추천 알고리즘 정교화 → 더욱 정확한 결과로 음악 추천 가능
    

- 플레이리스트에 추가 기능
    - 화면 상단의 하트 아이콘을 누르면 해당 곡을 플레이리스트에 추가 가능, 하단에 추가 완료 문구 나옴
    - 추가된 노래 목록은 화면 우측 상단의 플레이리스트 아이콘을 누르면 확인 가능
    - 플레이리스트에서는 검색 기능을 이용하여 추가한 음악 중 원하는 음악 검색 가능



### **Tab** 3️⃣ : **이벤트 및 행사 참여 기능**

![Tab3 포인트 사용 전](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/23dec221-3337-40e6-b1ff-789d8a91d0ca/Tab1.png)

Tab3 포인트 사용 전

![Tab3 포인트 사용 & 이벤트추가](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/d0f2efab-aa2b-49f5-811d-a6d81878391d/Tab3-1.gif)

Tab3 포인트 사용 & 이벤트추가

![Tab3 이벤트 추가 전](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/0848722b-ed7a-4c51-a309-e98ead56e80c/Tab3.png)

Tab3 이벤트 추가 전

![Tab3 이벤트 추가 후](https://prod-files-secure.s3.us-west-2.amazonaws.com/f6cb388f-3934-47d6-9928-26d2e10eb0fc/6c1c26bd-92cf-4dd2-9e4a-48cd5569d028/Tab3-1.png)

Tab3 이벤트 추가 후

- 관리자가 업로드 한 행사에 직접 참여 할 수 있는 기능
    - 아티스트가 공식적으로 올린 행사 포스터  확인 가능
    - 현재 시간을 기준으로 행사까지 남은 기간 계산하여 디데이 제공 기능
    - 화면 상단 우측에 내가 보유한 포인트 확인 가능
    
- 이벤트 상세 정보
    - 포스터 클릭 시 새로운 화면에서 위치, 날짜, 아티스트 정보 제공
    - 현재 보유 포인트 및 행사 참여에 필요한 포인트 정보 제공
    - 하단의 참여하기를 누르면 Tab1의 ‘예정된 활동’ 탭에 즉시 반영, 포인트 즉시 차감 및 하단에 포인트 차감 메세지 제공
    

