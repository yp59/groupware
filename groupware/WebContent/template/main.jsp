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
			width:1200px;
			margin:auto;
		}
		main::after {
			content:"";
			display:block;
			clear: both;
		}
		aside {
			float:left;
			width:20%;
			min-height:500px;
		}
		section {
			float:left;
			width:80%;
			min-height:500px;
		
		}
		
		header {
			min-height: 100px;
		}
		article {
			min-height:500px;
		}
		footer {
			
		}
	</style>
</head>
<body>
	
	<!-- 가장 바깥 영역 -->
	<main>
	<header>
	<div class="text-center"><h1>groupware</h1></div>
	</header>
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
			
		
			<article>
		
			</article>
			
		</section>
		 <footer>
		<div class="row text-center">&copy;저작권 입니다</div>
		</footer>
	</main>
</body>
</html>