<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>groupware mainPage</title>
	<link rel="stylesheet" type="text/css" href="/study/design/common.css">
	<style>
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
			min-height:300px;
		}
		footer {
			min-height:100px;
		}
	</style>
</head>
<body>
	<!-- 
		시맨틱 태그(semantic tag)
		- div처럼 다양한 용도로 사용되는 태그의 경우 태그명만으로 역할을 알 수 없다
		- id와 class를 부여하면 되지만 "개인차"가 존재하므로 사람에 따라 이해 여부가 달라진다
		
		- main : 페이지의 기본 영역
		- nav : 메뉴 영역
		- aside : 사이드 영역
		- section : 본문 영역
		- header : 상단 영역
		- article : 내용 영역
		- footer : 하단 영역
	 -->

	<!-- 가장 바깥 영역 -->
	<main>
		
		<!-- 사이드영역 -->
		<aside>
		
		</aside>
		
		<!-- 컨텐츠영역 -->
		<section>
			<header></header>
			<article></article>
			<footer></footer>
		</section>
		
	</main>
</body>
</html>