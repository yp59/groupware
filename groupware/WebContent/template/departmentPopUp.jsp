<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Layout 구현하기(1)</title>
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
			width:700px;
			margin:auto;
		}
		main::after {
			content:"";
			display:block;
			clear: both;
		}
		aside {
			float:left;
			width:40%;
			min-height:500px;
		}
		section {
			float:left;
			width:60%;
			min-height:500px;
		}
		
		header {
			min-height: 200px;
		}
		article {
			min-height:300px;
		}
		.view{
		display : none;
		}	
		</style><!-- .view로 부서별 display를 none으로 해서 해당 부서를 누르면 표가 나오도록 설정함. -->
</head>

