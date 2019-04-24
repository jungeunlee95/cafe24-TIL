# 사용자 계정 추가

옵션:

- b 이 위치 아래에 사용자 이름으로 된 홈디렉터리가 만들어집니다.

- d 이 위치 아래에 사용자 데이터가 저장됩니다.

- D 사용자를 새로 만드는 대신 useradd의 기본 설정을 바꿉니다.

- e 계정 만료일을 지정합니다.

- f 비밀번호 만료일을 지정합니다.

- g 사용자가 속할 그룹(1개)를 지정합니다.

- G 사용자가 속할 그룹(여러개)를 지정합니다.

- h 도움말을 보여줍니다.

- M 홈디렉터리를 만들지 않습니다.

- s 사용자가 기본으로 사용할 쉘(bash 등)을 지정합니다.

- u 사용자의 고유 숫자 ID를 지정합니다.

ex) **useradd test1**

​          \- 신규 생성 유저: test1

​          \- 디렉토리 : /home/test1

​          \- 기본적인 생성 방법으로 기본 유저를 생성 할때 사용 합니다.



ex) **useradd test1-d /var/data/test1**

​          \- 신규 생성 유저 : test1

​          \- 디렉토리 : /var/data/test1



---



리눅스서버구축.ppt 34

### 1 사용자 만들기

wheel 라는 -g(그룹)에 지정  // -d : dir {디렉토리 지정 }  // 사용자 id

`useradd -g wheel -d /home/webmaster web`

--> web이라는 사용자를 만듬

> - wheel, wheel group = 휠, 휠 그룹
>
> - 특별 시스템 권한이 부가되는, 휠 비트를 가진 사용자 계정
> - (휠 그룹) su 명령어를 사용하여 다른 사용자 계정에 접근할 수 있는 계정그룹

---

### 2 비밀번호

`#passwd webmater`

---

### 3 설정

`#vi /etc/ssh/sshd_config` 치면

/ 로 검색 -> Root

![1556067763544](assets/1556067763544.png)

주석 풀고, no로 설정

`# /etc/init.d/sshd restart`  : restart

---

### 4 로그인 해보기

> `sudo` : 현재 계정에서 다른 계정의 권한만 빌림
>
> `su` : 다른 계정으로 전환
>
> `su -` : 다른 계정으로 전환 + 그 계정의 환경 변수 적용

> `sudo su` : 계정을 독립적으로 root로 전환
>
> `sudo -s` : 현 계정의 모든 환경 변수들을 root 계정 쪽으로 넘김

새 shell열고

`ssh web@{{ip}}`

`sudo su-`

다시 root로 사용자 전환 하려면 : `su -`

다시 web으로 사용자 전환 하려면 : `su -web`

logout  : `exit`



---



`.bashrc` 파일,  => 찾아보자


