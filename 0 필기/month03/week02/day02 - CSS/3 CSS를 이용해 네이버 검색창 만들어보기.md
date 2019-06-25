```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {margin:0; padding:0;}

.total{
	width:800px; 
	margin: 50px auto; 
} 

.total input,
.total div,
.total a, 
.total button,
.total h1{
	display: inline;
	float: left; 
}  

.search-box{
	margin-top: 10px;
	margin-left: 25px;
    width: 510px; 
	height: 46px; 
	border: 2px solid #03cf5d;
} 
.search-box input{
    padding-left: 5px;
    width: 405px; 
	height: 44px; 
	border: none;
	outline: none; 
	font-size: 13pt;
}  
.search-box button{
    width: 30px; 
	height: 30px; 
	background: url('images/sp_search.png') no-repeat 0 -57px; 
	font-size:0;   
	border: 0;  
	outline: 0;
    margin-top: 9px;
    margin-left: 9px;
}  

.btn-search{
    width: 45px; 
	height: 46px; 
	background-color: #03cf5d;
}
.keyboard { 
	width: 25px; 
	height: 20px;  
	background : url('images/sp_search.png') no-repeat -30px -57px; 
	margin-top: 15px; 
	font-size:0;   
} 

.dropdown { 
	width: 20px; 
	height: 20px;  
	background : url('images/sp_search.png') no-repeat -82px -57px; 
	margin-top: 17px; 
	font-size:0;   
	margin-left: 5px;
    margin-right: 5px;
}   

.logo { 
	width:200px;
	height: 60px;
	background : url('images/sp_search.png') no-repeat 0 0; 
	font-size:0;  
}
</style>  
</head> 
<body>
	<div class="total">
		<h1 class="logo"></h1>
		<div class="search-box">
			<input type="text">
			<a href="#" class="keyboard">키보드</a>
			<a href="#" class="dropdown">드롭다운</a>
			<div class="btn-search">
				<button>돋보기</button>  
			</div>
		</div>
	</div>
</body>
</html>
```

![1561446701082](assets/1561446701082.png)