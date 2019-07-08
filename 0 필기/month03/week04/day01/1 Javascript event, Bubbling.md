[TOC]

---

# Javascript(Vanilla JS) event 

**시작하기 전 정리**

```
JavaScript 이벤트 종류
1. 마우스
2. 키보드 입력
3. HTML Frame
4. form & Input
5. touch

용어 정리
1. load : Event Name(Event Type)
2. onload, onclick : Event Attribute
3. function(){...} : Event Listener(Event Handler)


Event Model (Event Name에 Event Listener를 연결하는 방법)
1. DOM Level 0
    - Inline Event Model (태그 안에 `onclick='자바스크립트'` 넣는 것)
    - Basic Event Model (고전적인 이벤트, 기본 이벤트 처리) - `window.onload = function(){}`
        > 이건 이벤트를 하나밖에 못다는게 문제점!

2. DOM Level 2
    - Microsoft InternetExplorer Event Model -> attachEvent, detachEvent
    - Standard Event Model -> addEventListener, removeEventListener
```

<br>

---

## DOM Level 0 (Inline Event Model)

### [1] click event 등록 1 - `Inline`

> inline에 click1와 같이 직접 주거나, click2와 같이 함수로 호출할 수 있다.

```html
<script>
    /* DOM Level 0 Inline Event Model */
    var onClick = function(){
        console.log("clicked2");
    }
</script>
<body>
    <h1 onclick="console.log('clicked1')"> click1 </h1>
    <h1 onclick="onClick();"> click2 </h1>
</body>
```

<br>

### [2] click event 등록 2 -`window.onload = function(){}`

```html
<script>
    /*
    DOM Level 0 Inline Event Model
    (고전적인 이벤트, 기본 이벤트 처리) - `window.onload = function(){}`
    */

    window.onload = function () {
        var button1 = document.getElementById('button-1');

        button1.onclick = function(event){
            var counter = document.getElementById('counter-1');
            var count = Number(counter.innerText);
            counter.innerText =  "" + (count + 1);
        }
    }
</script>
<body>
    <button id="button-1"> button1</button>
    <h1>counter1: <span id="counter-1">0</span></h1>
</body>
```

<br>

### [3] click event 등록 3

- DOM Level 0 은 이벤트 핸들러를 하나만 연결할 수 있다. **(단점)**

buttion1과 buttion2에 같은 이벤트를 줄 때도 똑같은 코드를 2번 써야한다.

```js
var button1 = document.getElementById('button-1');
var button2 = document.getElementById('button-2');

button1.onclick = function(event) {
    var counter = document.getElementById('counter-1');
    var count = Number(counter.innerText);
    counter.innerText =  "" + (count + 1);
}

button2.onclick = function(event) {
    var counter = document.getElementById('counter-2');
    var count = Number(counter.innerText);
    counter.innerText =  "" + (count + 1);
}
```

**위의 코드 c-style로 고쳐보기**

```html
<script>
    window.onload = function () {
        var button1 = document.getElementById('button-1');
        var button2 = document.getElementById('button-2');

        button1.onclick =  button2.onclick = function(event) {
            // this == event.target (이벤트가 일어난 HTMLElement 객체)
            var counter = document.getElementById(this.getAttribute('data-counterid'));
            var count = Number(counter.innerText);
            counter.innerText =  "" + (count + 1);
        }
    }
</script>
<body>
    <button id="button-1" data-counterid="counter-1"> button1</button>
    <button id="button-2" data-counterid="counter-2"> button2</button>
    <h1>counter1: <span id="counter-1">0</span></h1>
    <h1>counter2: <span id="counter-2">0</span></h1>
</body>
```

<br>

------

## DOM Level 2 Standard Event Model(addEventListener, remove EventListener)

### [1] IE8 대응(cross-browser) 이벤트 등록

> Internet Explorer 8 - 오래된 브라우저 버전 지원

```html
<script>
    var registerEventHandler = function(element, eventName, handler){
        element && // element가 null이 아니라면
        element.attachEvent &&
        element.attachEvent('on'+eventName, handler);

        element && // element가 null이 아니라면
        element.addEventListener &&
        element.addEventListener(eventName, handler);
    }
    
    /*
    DOM Level 2 Standard Event Model :
    (addEventListener, remove EventListener)
    */
    window.onload = function () {
        var header = document.getElementById('header');

        // Multi Event Listener 연결 가능
        // Observer Pattern
        header.addEventListener('click', function(){
            console.log('click 1');
        });

        header.addEventListener('click', function(){
            console.log('click 2');
        });

        header.addEventListener('click', function(){
            console.log('click 3');
        });

        // < IE8 대응(cross-browser)
        registerEventHandler(header, 'click', function(){
            console.log('click 4')
        })

    }

</script>
<body>
    <h1 id="header">Click</h1>
</body>
```

<br>

### [2] DOM Level2 - 이벤트 기본 동작 막기

> 막는 이유 : <b style="color:blue;">validation</b>을 위해

#### 1, 기본 이벤트 막기

만약 ajax data 통신을 할 때, 아래의 코드와 같이 작성하면 계속 페이지가 reload된다.

data가 들어와도 페이지가 새로고침이 되어 남아있지 않는다.

`<a>`태그는 기본적으로 click event가 있기 때문이다. 

```html
<script>
    window.onload = function () {
        var button = document.getElementById('fetch-data');
        button.addEventListener('click', function(){
            console.log('start fetching....');
        });
    }
</script>
<body>
    <a href="" id="fetch-data">Click</a>
</body>
```

이 이벤트를 막기 위해 `event.preventDefault();`코드를 넣어주면 새로고침 되지 않는다.

```html
<script>
    window.onload = function () {
        var button = document.getElementById('fetch-data');
        button.addEventListener('click', function(event){
            event.preventDefault();
            console.log('start fetching....');
        });
    }
</script>
<body>
    <a href="" id="fetch-data">Click</a>
</body>
```

<br>

#### 2, form submit 이벤트 막기

**1) Level 0** 

```html
<script>
    window.onload = function () {
        var form = document.getElementById('form-login');
        
        // DOM Level0 - 이벤트 기본 동작 막기
        form.onsubmit = function(){
            var email = document.getElementById('email').value;

            if(email == ''){
                alert('이메일 값은 필수 입력 항목입니다.');
                document.getElementById('email').focus();
                return false;
            }

            var password = document.getElementById('password').value;
            if(password == ''){
                alert('이메일 값은 필수 입력 항목입니다.');
                document.getElementById('password').focus();
                return false;
            }

            return true;
        }
    }
</script>
<body> 
    <form id="form-login" method="post" action="login">
        <label>이메일</label><br>
        <input type="text" name="email" id="emial">
        <br><br>
        <label>비밀번호</label><br>
        <input type="text" name="password" id="password">
        <br><br>
        <input type="submit" value="로그인">
    </form>
</body>

```

**2) Level 2 ** 

```html
<script>
    window.onload = function () {
        // DOM Level2 - 이벤트 기본 동작 막기
        form.addEventListener('submit',function(event){

            event.preventDefault();

            var email = document.getElementById('email').value;

            console.log(email);
            if(email == ''){
                alert('이메일은 필수 입력 항목입니다.');
                document.getElementById('email').focus();
                return;
            }

            var password = document.getElementById('password').value;

            console.log(password);
            if(password == ''){
                alert('password는 필수 입력 항목입니다.');
                document.getElementById('password').focus();
                return false;
            }
            return;

            this.submit();
        });
    }
</script>
<body>
    <form id="form-login" method="post" action="login">
        <label>이메일</label><br>
        <input type="text" name="email" id="emial">
        <br><br>
        <label>비밀번호</label><br>
        <input type="text" name="password" id="password">
        <br><br>
        <input type="submit" value="로그인">
    </form>
</body>
```



**3) Achor에 적용하기(이유: ajax 통신을 위해서)** 

```JS
// Achor에 적용(이유 : AJAX 통신)
var button = document.getElementById('fetch-data');
button.addEventListener('click', function(event){
    event.preventDefault();
    console.log('start fetching....');
});
```

<br>

------

## Event Propagation(Event Bubbling)

<b style="color:blue;">이벤트 버블링이란?</b>

> 특정 요소에서 이벤트가 발생했을 때, 해당 이벤트가 상위의 요소들로 전달되어 가는 특성을 말한다.
>
> **ex)**
>
> ```html
> <body>
>     <div id="outer-div">
>         <div id="inner-div">
>             <h2 id="header">
>                 <span id="text">text</span>
>             </h2>
>         </div>
>     </div>
> </body>
> ```
>
> ![1562558370678](assets/1562558370678.png)

**Event Bubbling 막기**

```html
<script>
    window.onload = function () {
        //event bubbling
        // ie : outer-div > inner-div > header > text
        // others : outer-div < inner-div < header < text

        document.getElementById('outer-div').addEventListener('click', function () {
            console.log('outer-div!')
        });

        document.getElementById('inner-div').addEventListener('click', function (e) {
            // cross browser
            // e == null -> IE8인 경우(window.event)

            var event = e || window.event;

            // 이벤트 전달 막기
            event.cancelBubble = true; // IE8
            event.stopPropagation && event.stopPropagation(); // others

            console.log('inner-div')
        });

        document.getElementById('header').addEventListener('click', function () {
            console.log('header')
        });

        document.getElementById('text').addEventListener('click', function () {
            console.log('text')
        });
    }

</script>
<body>
<h1>Event Propagation(Bubbling)</h1>
<div id="outer-div">
    <div id="inner-div">
        <h2 id="header">
            <span id="text">text</span>
        </h2>
    </div>
</div>
</body>

```

