<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="upload/style.css" type="text/css"></link>
<script type="text/javascript" src="upload/jquery-1.8.2.min.js"></script>
</head>
<div class="kePublic">
<!--效果html开始-->
<!--图库弹出层 开始-->
<div class="mskelayBox">
  <div class="mske_html">
  
  </div>
  <img class="mskeClaose" src="images/mke_close.png" width="27" height="27" />
</div>
<!--图库弹出层 结束-->
  <a href="javascript:void(0)" class="msKeimgBox">
  	<img src="/pic/915f98ac-8796-4fe7-b8c5-dd714f7078f5-thumbnail.png" width="185" height="93" />
  <span class="hidden">
  	<img src="/pic/915f98ac-8796-4fe7-b8c5-dd714f7078f5.jpg" width="974" height="488" />
  </span>
  </a>
<!--效果html结束-->
</div>
<script type="text/javascript">
	$(".mskeClaose").click(function(){
		$(".mskeLayBg,.mskelayBox").hide()
	});
	$(".msKeimgBox").click(function(){
		$(".mske_html").html($(this).find(".hidden").html());
		$(".mskelayBox").fadeIn(300);
	});
	$(".mskeTogBtn").click(function(){
		$(".msKeimgBox").toggleClass("msKeimgBox2");
		$(this).toggleClass("mskeTogBtn2")
	});
	
</script>
</body>
</html>