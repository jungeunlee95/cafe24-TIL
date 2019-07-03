[TOC]

---

< 들어가기 전 . . ... >

**client쪽**

JavaScript (ECMAScript) & jQuery

-> component programming(vue, react) + 통신

처음 javascript 배울 때는 이클립스로, react는 [웹스톰->리눅스]순으로 사용할거임

---

# javascript

- 브라우저 내에 내장된 자바스크립트 실행엔진 (해석기)를 통해 실행되어지고 브라우저 화면에 반영된다.
- 객체 기반 스크립트 언어
- prototype이라는 객체 생성 지원 개념이 있다.

---

## linux에 node 설치

<https://www.lesstif.com/pages/viewpage.action?pageId=6979743>

`# rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm`

`# yum -y install npm`

`# yum install nodejs`

```shell
[root@localhost ~]# node --version
v0.10.48
```



### js 파일 만들어서 실행해보기

```shell
[root@localhost ~]# cd dowork/
[root@localhost dowork]# ls
lx01Java  network  pgsql-sample-data  python-projects  sysprog  vitest
[root@localhost dowork]# mkdir js
[root@localhost dowork]# cd js/
[root@localhost js]# vi hello.js
 > `console.log("Hello!!!");` 
[root@localhost js]# 
[root@localhost js]# node hello.js 
Hello!!!
```



###  **간단한 node 웹 서버 실행해보기**

위치 : `/root/dowork/js`

`# vi httpd.js`

```js
const http = require('http');
 
const hostname = '0.0.0.0';
const port = '9999';
 
// http모듈의 createServer 함수를 호출하여 서버를 생성합니다.
// req: request. 웹 요청 매개변수, res: response. 웹 응답 매개변수
httpd = http.createServer(function (req, res) {
    // writeHead: 응답 헤더를 작성합니다.
    // 200: 응답 성공, text/html: html문서
    res.writeHead(200, {'Content-Type': 'text/html'});
    // end: 응답 본문을 작성합니다.
    res.end('Hello World111');   
});

// listen: 매개변수로 포트와 호스트를 지정합니다. 
httpd.listen(port, hostname, function(){    
    console.log('server start');
});
```

`# node httpd.js`

![1562117709404](/assets/1562117709404.png)
