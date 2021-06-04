<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	//실제 context path를 구하는 명령
	//template 페이지의 모든 경로는 절대경로로 작성해야 한다. 가급적 절대경로로 작성하는 것을 추천
	String root = request.getContextPath();
%>        
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Layout 구현하기(1)</title>
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<style>
	/*수업듣고 header section footer 다 나눠줘야 한다.*/
	/*레이아웃 구분선 완성 후 지우기*/
		main, aside, section, article, header, footer{
			border:1px dotted black;
		}
		
		/* 리셋 스타일 */
		html, body{
			margin:0;
			padding:0;
		}
		
		main {
			width:100%;
/* 			width:1200px; */
			margin:auto;
		}
		main::after {
			content:"";
			display:block;
			clear: both;
		}
		aside {
			float:left;
			width:10%;
/* 			width:20%; */
			min-height:500px;
			background-color: rgb(224,224,224);
		}
		
		aside a{
		 color:rgb(52, 152, 219);
		 text-decoration: none;
		}
		
		section {
			float:left;
			width:90%;
/* 			width:80%; */
			min-height:500px;
		
		}
		
		header {
			min-height: 0;
		}
		article {
			min-height:500px;
		}
		footer {
			
		}
		
		.company-logo{
		 padding-top:10px;
		 padding-bottom:10px;
		 color:rgb(52, 152, 219);
		 font-style: sanserif;
		 font-size: 30px;
		 font-weight: bold;
		}
		
		
		.nav{
			background-color: rgb(52, 152, 219);
		}
		
		.float-container > .left {
			float:left;
		}
		.float-container > .right {
			float:right;
		}
		
		.float-container{
			padding:15px;
		}
		
		.float-container a {
			margin-left:3rem;
			padding-top:0.2rem;
			padding-bottom:0.2rem;
			display:inline-block;
			text-decoration: none;
			color:white;

		}
		
		.float-container a:hover{
			color:darkgray;
		}
	
	</style>
</head>
<body>
	
	<!-- 가장 바깥 영역 -->
	<main>
			<!-- 로고영역 -->
			<div class="text-center ">
				<div class="company-logo">
				groupware
				</div>
			
			</div>
			
			<!-- 네비게이션 영역 -->
			<div class="float-container nav">
				<div></div>
				<div class="right">
					<a href="#">전자결재</a>
					<a href="#">일정관리</a>
					<a href="#">근태관리</a>
					<a href="#">게시판</a>
					<a href="#">마이페이지</a>
				</div>
			</div>
			
			<!-- 사이드영역 -->
				<aside>
			<div class="menu">
				<ul>
					<li class = "menu menu-title">
						<a href="#">제목</a>
					</li>
				<ul>
					<li class = "menu menu_detail">
					<a href="#">분류</a>
					</li>
					<li class = "menu menu_detail">
					<a href="#">분류</a>
					</li>
				</ul>
				</ul>
				<ul>
					<li class = "menu menu-title">
						<a href="#">제목</a>
					</li>
				<ul>
					<li class = "menu menu_detail">
					<a href="#">분류</a>
					</li>
					<li class = "menu menu_detail">
					<a href="#">분류</a>
					</li>
				</ul>
				</ul>
				<ul>
					<li class = "menu menu-title">
						<a href="#">제목</a>
					</li>
				<ul>
					<li class = "menu menu_detail">
					<a href="#">분류</a>
					</li>
					<li class = "menu menu_detail">
					<a href="#">분류</a>
					</li>
				</ul>
				</ul>
				<ul>
					<li class = "menu menu-title">
						<a href="#">제목</a>
					</li>
				<ul>
					<li class = "menu menu_detail">
					<a href="#">분류</a>
					</li>
					<li class = "menu menu_detail">
					<a href="#">분류</a>
					</li>
				</ul>
				</ul>
			</div>
			</aside>
				
			
			<!-- 컨텐츠영역 -->
			<section>
				<header>
				</header>
				<article>
			
				</article>
				
			</section>
			 <footer>
			<div class="row text-center">&copy;저작권 입니다</div>
			</footer>
	</main>
</body>
</html>