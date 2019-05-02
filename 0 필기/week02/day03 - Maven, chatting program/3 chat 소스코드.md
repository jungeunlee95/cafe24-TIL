**ChatClientApp.java**

```java
package com.cafe24.network.chat.client;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.Scanner;

public class ChatClientApp {
	
	private static final String SERVER_IP = "192.168.1.12";
	private static final int SERVER_PORT = 9999;

	public static void main(String[] args) {
		String name = null;
		Scanner scanner = new Scanner(System.in);

		while( true ) {
			
			System.out.println("대화명을 입력하세요.");
			System.out.print(">>> ");
			name = scanner.nextLine();
			
			if (name.isEmpty() == false ) {
				break;
			}
			
			System.out.println("대화명은 한글자 이상 입력해야 합니다.\n");
		}
		
		// 1. 소켓 만들고 
		Socket socket = null;
		try {
			// 1-1 소켓 생성
			socket = new Socket();
			
			// 서버 연결
			socket.connect(new InetSocketAddress(SERVER_IP, SERVER_PORT));
			
			// 2. iostream 구현
			BufferedReader br = new BufferedReader(
							new InputStreamReader(socket.getInputStream(), "utf-8"));
			
			PrintWriter pw = new PrintWriter(
							new OutputStreamWriter(socket.getOutputStream(), "utf-8"),true);
			
			// 3. join 프로토콜  -> 서버가 닉네임 받아서 처리 / 성공하면 다음 실행 
			pw.println("join:"+ name);
			String ack = br.readLine();  // blocking
//			System.out.println("------->" + ack);
			
			new ChatWindow(name, socket).show(); // name이랑 소켓도 넘겨야함
		} catch(IOException e) {
			e.printStackTrace();
		} finally {
			scanner.close();
		}

	}

}

```

**ChatWindow.java**

```java
package com.cafe24.network.chat.client;

import java.awt.BorderLayout;
import java.awt.Button;
import java.awt.Color;
import java.awt.Frame;
import java.awt.Panel;
import java.awt.TextArea;
import java.awt.TextField;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.Socket;

public class ChatWindow {

	private Frame frame;
	private Panel pannel;
	private Button buttonSend;
	private TextField textField;
	private TextArea textArea;
	private Socket socket;
	private String name;
	
	private PrintWriter pw;
	private BufferedReader br;
	
	
	public ChatWindow(String name, Socket socket) {
		this.socket = socket;
		this.name = name;
		frame = new Frame(name); // 큰 틀
		pannel = new Panel(); // 아래 대화 입력
		buttonSend = new Button("Send"); // 패널의 자식
		textField = new TextField(); // 패널의 자석
		textArea = new TextArea(30, 80); // 대화 뜨는 공간
	}

	private void finish() {
		// socket 정리
		System.exit(0);
	}

	public void show() throws IOException, UnsupportedEncodingException {
		// Button
		buttonSend.setBackground(Color.GRAY);
		buttonSend.setForeground(Color.WHITE);
		buttonSend.addActionListener(new ActionListener() { // 버튼이 눌려지는지 기다림
			@Override
			public void actionPerformed(ActionEvent actionEvent) {
				sendMessage();
			}
		});

		// Textfield
		textField.setColumns(80);
		textField.addKeyListener(new KeyAdapter() {
			@Override
			public void keyPressed(KeyEvent e) {
				char keyCode = e.getKeyChar();
				if (keyCode == KeyEvent.VK_ENTER) {
					sendMessage();
				}
			}
		}); // 엔터 쳤을 때

		// Pannel
		pannel.setBackground(Color.LIGHT_GRAY);
		pannel.add(textField);
		pannel.add(buttonSend);
		frame.add(BorderLayout.SOUTH, pannel);

		// TextArea
		textArea.setEditable(false);
		frame.add(BorderLayout.CENTER, textArea);

		// Frame
		frame.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				finish();
			}
		});
		frame.setVisible(true);
		frame.pack();

		// pw, br
		pw = new PrintWriter(new OutputStreamWriter(socket.getOutputStream(), "utf-8"), true);
		br = new BufferedReader(new InputStreamReader(socket.getInputStream(), "utf-8"));


		// Thread 생성
		new ReceiveThread().start();
	}

	private void updateTextArea(String message) { // thread에서 불러야함
		textArea.append(message);
		textArea.append("\n");
	}

	
	private void sendMessage() {
		String message = textField.getText();

		pw.println("message:" + message);
				
		textField.setText("");
		textField.requestFocus();
	}
	
	private class ReceiveThread extends Thread {
		@Override
		public void run() {
			while(true){
				try {
					
					String reply = br.readLine(); // blocking

					if (reply == null){
						break;
					}
					
					updateTextArea(reply);

				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		}
		
	}
}

```

**ChatServer.java**

```java
package com.cafe24.network.chat.server;

import java.io.IOException;
import java.io.Writer;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class ChatServer {
	
	private static final int PORT = 9999;
	public static List<Writer> listWriters = new ArrayList<Writer>();
	
	public static void main(String[] args) {
		
		ServerSocket serverSocket = null;
		
		try {
			
			serverSocket = new ServerSocket();
			
			serverSocket.bind(new InetSocketAddress("0.0.0.0", PORT));
			System.out.println("server port : " + PORT);
			
			while(true) {
				Socket socket = serverSocket.accept();
				
				Thread thread = new ChatServerReceiveThread(socket, listWriters);
				thread.start();
			}
		
		}catch(IOException e) {
			e.printStackTrace();
		}finally {
			try {
				if(serverSocket != null && serverSocket.isClosed()) {
					serverSocket.close();
				}
			}catch(IOException e) {
				e.printStackTrace();
			}
		}
		
	}
	public static void log(String log) {
		System.out.println("[server# "+ Thread.currentThread().getId() + "] " + log);
		
	}

}

```

**CharServerReceiveThread.java**

```java
package com.cafe24.network.chat.server;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketException;
import java.util.List;

public class ChatServerReceiveThread extends Thread {

	private Socket socket;
	private String nickname;
	List<Writer> listWriters;
	PrintWriter pw = null;
	BufferedReader br = null;
	
	public ChatServerReceiveThread(Socket socket, List<Writer> listWriters) {
		this.socket = socket;
		this.listWriters = listWriters;
	}

	@Override
	public void run() {
		InetSocketAddress inetRemoteSocketAddress = (InetSocketAddress) socket.getRemoteSocketAddress();
		String remoteHostAddress = inetRemoteSocketAddress.getAddress().getHostAddress();
		int remotePort = inetRemoteSocketAddress.getPort();
		System.out.println("[server] 입장 : " + remoteHostAddress + " : " + remotePort);

 		try {
 			br = new BufferedReader(new InputStreamReader(socket.getInputStream(), "utf-8"));
 			pw = new PrintWriter(new OutputStreamWriter(socket.getOutputStream(), "utf-8"), true);

			while(true) {
				String data = br.readLine();
				
				if (data == null) {
					System.out.println("갑자기 끔");
					doQuit(pw);
					break;
				}
				
//				System.out.println(">>>>>>received:" + data);
				
				// 프로토콜 분석
				String[] tokens = data.split(":");
				
				if("join".equals(tokens[0])) {
					doJoin(tokens[1], pw);
				}else if ("message".equals(tokens[0])) {
					if(tokens[1].isEmpty()==false) {
						doMessage(tokens[1]);
					}
				}else {
					ChatServer.log("알수없는 요청");
				}
			}
			
		} catch (SocketException e) {
//			System.out.println(Thread.currentThread().getId());
			System.out.println("[server] sudden closed by client");
			doQuit(pw);
		} catch (IOException e) { // 정상종료 안하고 확 꺼버린 ..!
			e.printStackTrace();
		} finally {
			try {
				if (socket != null && socket.isClosed()) {
					socket.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private void doJoin(String nickName, Writer writer) {
		this.nickname = nickName;
//		System.out.println("@@@@닉네임:" + nickName);
		// 누가 들어왔다고
		String data = nickName + "님이 참여하셨습니다.";
		broadcast(data);
		
		// writer pool 에 현재 스레드 printWriter를 저장
		addWriter(writer);
		
		// ack 보내기
		pw.println("대화에 참가하셨습니다.");
		pw.flush();
		
	}
	
	private void addWriter(Writer writer) {
		synchronized (listWriters) {
			listWriters.add(writer);
		}
//		for(Writer writer2 : listWriters) {
//			System.out.println(writer2);
//		}
	}
	
	private void broadcast(String data) {
		synchronized (listWriters) {
			for(Writer writer : listWriters) {
				PrintWriter pw = (PrintWriter)writer;
				pw.println(nickname + " : " +data);
				pw.flush();
			}
		}
	}
	
	private void doMessage(String message) {
		broadcast(message);
	}
	
	private void doQuit(Writer writer) {
		removeWriter(writer);
		
		String data = nickname + "님이 퇴장하셨습니다.";
		synchronized (listWriters) {
			for(Writer writer2 : listWriters) {
				PrintWriter pw = (PrintWriter)writer2;
				pw.println("---------" +data+"---------");
				pw.flush();
			}
		}
	}
	
	private void removeWriter(Writer writer) {
		listWriters.remove(writer);
	}

}

```

