<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/menu.css">
	<title>Layout 구현하기(1)</title>
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
		/*aside {
			float:left;
			width:20%;
			min-height:500px;
		}*/
		section {
			float:left;
			width:100%;
			min-height:500px;
		}
		.design{
		
		width : 100%;
		background-color :#f9f9f9;
		}
 		.fon-color{
 		color:#3498DB;
 		font-size :15px;
 		font-weight : bold;
 		}
		</style>
</head>

