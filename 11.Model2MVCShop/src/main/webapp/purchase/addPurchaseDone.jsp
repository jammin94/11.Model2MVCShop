<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
 
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">    


  <div class="col-xs-6 col-md-3 col-md-offset-3">
      <img src="/images/uploadFiles/${product.fileName}"/>
  </div>


<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">물품번호</th>
      <th scope="col">구매자아이디</th>
      <th scope="col">구매방법</th>
      <th scope="col">구매자이름</th>
      <th scope="col">구매자연락처</th>
      <th scope="col">구매자주소</th>
      <th scope="col">구매요청사항</th>
      <th scope="col">배송희망일자</th>
    </tr>
  </thead>
  <tbody>
	<tr>
 		<td>${purchase.purchaseProd.prodNo }</td>
 		<td>${purchase.buyer.userId }</td>
 		<td>${purchase.paymentOption eq '1' ? '현금구매' : '카드구매'}</td>
 		<td>${purchase.receiverName }</td>
 		<td>${purchase.receiverPhone }</td>
 		<td>${purchase.divyAddr }</td>
 		<td>${purchase.divyRequest }</td>
 		<td>${purchase.divyDate }</td>
	</tr>
  </tbody>
</table>

<a href="/purchase/listPurchase">확인</a>
<!-- table End /////////////////////////////////////-->

</div>

	
</body>

</html>