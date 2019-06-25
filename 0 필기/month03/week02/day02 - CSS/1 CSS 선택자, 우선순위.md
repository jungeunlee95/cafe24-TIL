[TOC]

---



# css 선택자, 우선순위



## 기본 모양 : 선택자 { 속성: 속성값; }

> 기본적으로 태그, 클래스, 아이디 선택자 등이 있으며 그 외에 종속, 하위, 전체, 그룹 선택자 등이 웹 개발 실무에서 많이 사용된다.

---



## 태그 선택자

> HTML 태그를 선택자로 사용하는 것
>
> **ex)**
>
> ```css
> h1{font-size: 20px; color: #f00; margin:10px;}
> h2{font-size: 14px; color: #36f; margin:5px; }
> p {font-size: 12px; color: #333; margin:5px; }
> ```

---



## 클래스 선택자

> - 직접 이름(class)를 만들어 속성 지정
>
> - 모양 : `.CLASSNAME { 속성이름: 속성값; }`
> - .(점)으로 시작하고 첫문자는 영문자로 시작해야 하며, 대소문자 구별
> - 태그 선택자가 페이지내 모든 태그에 적용되었다면 클래스 선택자는 클래스 속성에서 같은 클래스 이름을 가진  엘리멘트들이 적용 대상이 된다.
>
> **ex)**
>
> ```html
> <style>
> .head{
> 	font-size: 60px;
> 	color: #333; 
> 	border:1px solid #999; 
> 	margin:25px; 
> 	padding:10px;
> }
> </style>
> <body>
> 	<h1 class='head'>Hello World</h1>
> </body>
> ```

---



## 아이디 선택자

> - 직접 이름(id)를 만들어 속성 지정
>
> - 모양 : `#id { 속성이름: 속성값; }`
> - #(샵)으로 시작하고 첫문자는 영문자로 시작해야 하며, 대소문자 구별
> - 기본적으로 HTML 엘리멘트의 id는 유일해야 하기 때문에  하나의 엘리멘트는 하나의 유일한 id를 가진다. 따라서 클래스 선택자와 차이는 페이지내 특정 하나의 엘리멘트에만 적용할 수 있다.  
>
> **ex)**
>
> ```html
> <style>
> #head{
> 	font-size: 60px;
> 	color: #333; 
> 	border:1px solid #999; 
> 	margin:25px; 
> 	padding:10px;
> }
> </style>
> <body>
> 	<h1 id='head'>Hello World</h1>
> </body>
> ```

---



## 종속 선택자

> - 태그, 클래스, 아이디 선택자가 결합되 형태의 선택자
>
> - 태그에 결합된 형태는 태그중에 특정 아이디, 특정 클래스에만 적용
> - 클래스와 아이디에 모두 적용해서 스타일을 적용할 수 있지만, 너무 복잡한 조합은 피하는 것이 좋다.
>
> **ex)**
>
> **모양**
>
> ```css
> h1#head { … } 
> .headline.selected { … }
> input#user-id.focused { …}
> p.title { … }
> ```
>
> **코드**
>
> ```html
> <style>
>     p.txt1{color: red; font-weight: bold;}
>     .txt1 {font-weight: normal; color: blue;}
> </style>
> <body>
> 	<p class='txt1'> Hello World </p>
> </body>
> ```

------



## 하위 선택자

> - 선택자 내부의 자식 선택자에 속성을 지정하는 방식이다.
>
> - 엘리멘트 개별로 클래스 또는 아이디를 주지 않아도 스타일을 적용할 수 있다
>
> **ex)**
>
> **모양**
>
> ```css
> body h1, body h2, body p { … } 
> p .txt1 { … }     
> .headline span                                            
> ```
>
> **코드**
>
> ```html
> <style>
>     p a {text-decoration:underline; font-weight: bold; color: #F60;}
> </style>
> <body>
> 	<p class='txt1'> Hello <a>World</a> </p>
> </body>
> ```

---



## 그룹 선택자

> - 각각의 선택자를 그룹으 지어 속성을 부여하는 것
>
> - 선택자들 간에 공통적인 속성이 있는 경우 일괄 적용으로 편리하게 사용
>
> **ex)**
>
> **모양**
>
> ```css
> body h1, body h2, body p { … } 
> .right_box, .left_box { … }                               
> ```
>
> **코드**
>
> ```html
> <style>
>     h1, h2, h3 { color: #F60; text-decoration:underline; }
> </style>
> <body>
> 	<h1> Hello World </h1>
>     <h2> Hello World </h2>
>     <h3> Hello World </h3>
> </body>
> ```

---



## 수도 선택자

> - 선택자로 바로 사용되는 것이 아니고 선택자와 함께 사용되어 선택자를 보조 하는 역할
>
> - 그 역할에 따라 몇가지가 정해져 있다.
>
>   > ```
>   > :hover   -> 마우스의 커서가 올라가 있는 상태
>   > :active  -> 마우스 커서를 클릭한 순간부터 놀기 직전까지 상태
>   > :link     -> 링크를 클릭하지 않은 그냥 링크만 되어 있는 상태
>   > :visited -> 링크를 눌러서 방문한 후 상태
>   > :before -> 문장이 시작되기 전
>   > :after   -> 문장이 끝난 다음
>   > 
>   > :hover, :active, :link, :visited 는 a 태그와 함께 링크를 데코레이션 할 때 많이 사용된다                         
>   > ```
>
> **코드**
>
> ```html
> <style type="text/css">
> a:link    {color: #F60;text-decoration: none;}
> a:hover   {color: #06F;text-decoration: underline;}
> a:visited {color: #999;}
> a:active  {color: #F00;text-decoration: line-through;}
> 
> h1:before {content: url(images/bul1.gif);}
> h1:after  {content:  url(images/bul2.gif);}
> 
> table    {border-collapse:collapse; width:500px;}
> td 	 { padding:10px;}
> tr:hover { background-color: #FC6; }
> 
> </style>
> <body>
> <h1>제주글꼴 <strong>공개</strong> 되었습니다. </h1>
> <p>원래는 2010년 5월 4일 공개된 글꼴이지만, <a href="#">다시 여러분에게 안내해</a> 드리겠습니다. 첫번째로 제가 생각한 내용은 대한민국에서 가장 유명한 관광지인 <a href="#">제주를 상징할만한 요소</a>는 많지만 디자인적으로 통일된 무언가가 있어야 하겠다. 두번째로 <a href="#">공항부터 시작해서 관광객들이</a> 접하는 모든 곳에서 일관된 디자인의 통일성과 상징성이 필요하다. </p>
> 
> <table border="1">
>   <tr>
>     <td>test1</td>
>     <td>test2</td>
>     <td>test3</td>
>     <td>test4</td>
>   </tr>
>   <tr>
>     <td>test1</td>
>     <td>test2</td>
>     <td>test3</td>
>     <td>test4</td>
>   </tr>
> </table>
> </body>
> ```

------



## 전체 선택자

> - 말그대로 전체 엘리멘트를 뜻한다. (와일드 카드)
>
> - 스타일이 적용되는 모든 엘리멘트에 일괄 적용하고자 할 때 사용한다.
>
> - 모양 : `* { margin:0; padding:0 }` : 기본중에 기본!!!!!!!
>
>   > ```
>   > ex)
>   > 브라우저 별로 모든 엘리멘트는 기본적인 margin값과 padding값을 가지고 있다. 그런데 브라우저별로 이 값이 틀리기 때문에 디폴트로 0로 만들고 시작하자 -> 기본중에 기본!!!!!!!으로 꼭 설정하자!!!!ㄴ
>   > ```
>
> - 하위 선택자에 적용된 경우
>
>   > ```
>   > #idname *  또는  .classname *
>   > 아이디가 idname 인 엘리멘트 내부의 모든 자식 엘리멘트에 해당 속성들이
>   > 적용될 것이다. 
>   > 클래스 이름이 classname 인 엘리멘틀들의 내부의  모든 자식 엘리멘트들에게 해당 속성들이 적용될 것이다. 
>   > ```

---



## CSS 우선순위

1. 속성 값 뒤에 `!important` 를 붙인 속성
2. `HTML`에서 [`style`](https://ofcourse.kr/html-course/태그의-속성#style-속성)을 직접 지정한 속성
3. `#id` 로 지정한 속성
4. `.클래스`, `:추상클래스` 로 지정한 속성
5. `태그이름` 으로 지정한 속성
6. 상위 객체에 의해 **상속**된 속성

> 점수로 본다면 
>
> 아이디 : 10000000	> 	클래스 : 100	>	태그 : 1

---

