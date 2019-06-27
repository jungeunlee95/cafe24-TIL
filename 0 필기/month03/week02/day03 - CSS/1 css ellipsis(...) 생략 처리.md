[TOC]

---

# css ellipsis(...) 생략 처리

```html
<style>
/* 다중 라인 처리 */
p.text1{
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 3; /* 라인수 */
    -webkit-box-orient: vertical;
    word-wrap:break-word; 
    line-height: 1.2em;
    height: 3.6em; /* line-height 가 1.2em 이고 3라인을 자르기 때문에 height는 1.2em * 3 = 3.6em */
}
    
/* 한줄 라인 처리 - Block 태그에서만 적용 */   
p.text2 {
    width:70px; /* 글자 넓이 지정 */
    padding:0 5px;
    overflow:hidden; /* 글자 넓이 넘을 경우 보이지 않게 처리 */
    text-overflow:ellipsis; /* 글자 넓이 넘을 경우 생략 부호 표시*/
    white-space:nowrap; /* 공백 문자의 경우 줄바꿈 X, 한줄로 나오게 처리 */
}
</style>
<body>
    <p class="text1">
        aaaaaaaaaaaaaaaaa<br>
        bbbbbbbbbbbbbbbb<br>
        ccccccccccccccc<br>
        dddddddddddddd<br>  
    </p>
    <p class="text2">영문자는 abc 로 시작됩니다.</p>
</body>
```

> <화면출력>
>
> ```
> aaaaaaaaaaaaaaaaa
> bbbbbbbbbbbbbbbb
> ccccccccccc...
> 
> 영문자는 A...
> ```