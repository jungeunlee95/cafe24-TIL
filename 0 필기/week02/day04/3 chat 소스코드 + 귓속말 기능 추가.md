# 기존 코드에서 귓속말 기능 추가

---

## 추가부분

**사용자를 저장하는 list를 Map으로 바꿔 사용자의 닉네임과 소켓정보를 같이 받음**

`public static Map<String, Object> listWriters = new HashMap<>();`

---

**ChatWindow.java**

> 귓속말 형식은
>
> /귓속말 [닉네임] : [내용]

```java
private void sendMessage() {
    String message = textField.getText();

    if(message.charAt(0)==('/')) {
        if(message.length()<4) {
            textArea.append("-------------------------------------------------------\n"+
                            "\t\t잘못된 입력입니다\n \t\t귓속말을 보내시려면 아래의 형식을 맞춰주세요.\n \t\t/귓속말 [상대방닉네임] : [내용]\n"+
                            "-------------------------------------------------------\n");
        }else if(message.substring(0, 4).equals("/귓속말")) {
            pw.println("wisper:" + message +":"+name);
        }else {
            textArea.append("-------------------------------------------------------\n"+
                            "\t\t잘못된 입력입니다\n \t\t귓속말을 보내시려면 아래의 형식을 맞춰주세요.\n \t\t/귓속말 [상대방닉네임] : [내용]\n"+
                            "-------------------------------------------------------\n");
        }
    }else {
        pw.println("message:" + message);
    }
    textField.setText("");
    textField.requestFocus();
}
```





**ChatServerReceiveThread.java**

프로토콜 분석 부분

-> 잘못된 형식 걸러줌

```java
// 프로토콜 분석
String[] tokens = data.split(":");

if("join".equals(tokens[0])) {
    doJoin(tokens[1], pw);
}else if ("message".equals(tokens[0])) {
    if(tokens[1].isEmpty()==false) {
        doMessage(tokens[1]);
    }
}else if("wisper".equals(tokens[0])){
    //					System.out.println(tokens[0] + "@@@"+ tokens[1] + "@@@"+ tokens[2] + "@@@");
    //					                     wisper @@@ /귓속말 아아  @@@ 안녕?@@@
    if (tokens.length<4) {
        pw.println("-------------------------------------------------------\n"
                   + "\t\t잘못된 입력입니다.\n-------------------------------------------------------");
    }else {
        doWisper(tokens[1].substring(5), tokens[2], tokens[3]);
    }
}else {
    ChatServer.log("알수없는 요청");
}
```

doWisper() 메소드

-> 닉네임이 없을경우 걸러줌!

-> pw : 귓속말 보내는 사람 = 나

-> pw2: 귓속말 받는 사람 = 상대

```java
private void doWisper(String name, String message, String me) {

    //		System.out.println(name + "@@@@" + message+"@@@@@@@@@@@@@@@@@");
    //		아아 @@@@ 안녕?@@@@@@@@@@@@@@@@@
    name = name.trim();
    me = me.trim();

    PrintWriter pw2 = null;
    for(Entry<String, Object> writer : listWriters.entrySet()) {
        if(writer.getKey().equals(name)) {
            //				System.out.println("알맞은 닉네임 찾아서 들어옴");
            pw2 = (PrintWriter) writer.getValue();				
        }
    }
    if(pw2 == null) {
        pw.println("-------------------------------------------------------\n \t\t사용자 닉네임을 올바르게 입력해 주세요.\n-------------------------------------------------------");
    }else {
        //			System.out.println(name + ", "+ message + ", "+ me + ", " + pw);
        pw.println("[ 귓속말 >>" + name + " : " + message +" ]");
        pw2.println("[ 귓속말 <<" + me + " : " + message +" ]");
        pw2.flush();			
    }

}
```



















