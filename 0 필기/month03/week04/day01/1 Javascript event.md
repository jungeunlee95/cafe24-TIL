```
Javascript event
이벤트 종류
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