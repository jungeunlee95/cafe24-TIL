[TOC]



회원가입을 하면 해당 사용자의 블로그가 자동 생성 >> 블로그 테이블

`http://localhost:8088/jblog/${사용자 아이디}`

> url은 반드시 회원가입 사용자 아이디
>
> @PATH 사용 중요함!!! 



블로그 메인 

`http://localhost:8088/jblog/${사용자 아이디}/{카테고리no}/{글no}`

`http://localhost:8088/jblog/${사용자 아이디}` -> 얘도 첫번재 카테고리의 첫번째 글이 나와야함

> 글 쓸때 카테고리 꼭 선택!! 하게 해!



-- 기본 구성 -- :file_folder:

MainController - 메인화면 보여주기

UserController - 로그인 회원가입 ..  -> UserService

BlogController(/{id}, /{id}/{cno},/{id}/{cno}/{bno}) -> BlogService





UserDao 

BlogDao

PostDao

CategoryDao



User 의 id(Varchar20)가 PK! no 필요없어 그리고 Blog id와 1:1관계 하는게 편함 



html editor

