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
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetPurchaseList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
		}
		
		
		//============= "검색"  Event  처리 =============	
		 $(function() {
			 
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetPurchaseList(1);
			});

		});	

	
	
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>${user.role eq 'admin' ? '배송처리' : '구매목록'}</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				  <input type="radio" id="Desc" name="Order" value="Desc">
					<label for="Desc">가격 높은순</label>
					<input type="radio" id="Asc" name="Order" value="Asc">
					<label for="Asc">가격 낮은순</label>  
				</form>
	    	</div>   	
		</div>

<!--   user 전용 table Start /////////////////////////////////////-->
		
<c:if test="${user.role eq 'user'}">

<div class="row">
     <c:forEach var="i" items= "${list}" varStatus="status" >
	  <div class="col-sm-3 col-md-2">
	    <div class="thumbnail">
	      <a href="/purchase/getPurchase/${i.tranNo}"><img src="/images/uploadFiles/${i.purchaseProd.fileName}"/></a>
	      	
	      <div class="caption">
	        <h3>${i.purchaseProd.prodName }</h3>
	        <h4>${i.purchaseProd.price }원</h4>
	        <h5>배송상태 : 
	        <c:choose>
		 	<c:when test="${i.tranCode.trim() eq '0' }">
		 		현재 구매가능합니다.
		 	</c:when>
		 	<c:when test="${i.tranCode.trim() eq '1' }">
		 		현재 구매완료했습니다.
		 	</c:when>
		 	<c:when test="${i.tranCode.trim() eq '2' }">
		 		현재 배송중입니다.
		 	</c:when>
		 	<c:otherwise>
		 		배송완료 했습니다.
		 	</c:otherwise>
		 </c:choose></h5>

 		<c:if test="${ i.tranCode.trim() eq '1'}">
 			<a href="/purchase/updatePurchase/${i.tranNo }">구매 상세정보 수정하기</a>
 		</c:if>
 		<c:if test="${ i.tranCode.trim() eq '2'}">
 			<a href="/purchase/updateTranCode?tranNo=${i.tranNo }&tranCode=3">도착완료 확인하기</a>
 		</c:if>
 		
 		</div>
		</div>
	  </div>
	</c:forEach>
</div>

</c:if>

<!--  user 전용 table End /////////////////////////////////////-->
		
<!--   admin 전용 table Start /////////////////////////////////////-->
      
<c:if test="${user.role eq 'admin'}">

<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">상품명</th>
      <th scope="col">회원ID</th>
      <th scope="col">회원명</th>
      <th scope="col">전화번호</th>
      <th scope="col">배송현황</th>
      <th scope="col">정보수정</th>
      <th scope="col">배송처리</th>
    </tr>
  </thead>
  <tbody>
 	<c:forEach var="i" items= "${list}" varStatus="status" >
 		<tr>
 		<th scope="row">${status.count }</th>
 		<td><a href="/product/getProduct/${i.purchaseProd.prodNo }">${i.purchaseProd.prodNo }</a></td>
 		<c:if test="${user.role eq 'admin'}">
 			<td><a href="/user/getUser?userId=${i.buyer.userId }">${i.buyer.userId }</a></td>
 		</c:if>
 		<td>${i.receiverName }</td>
 		<td>${i.receiverPhone }</td>
 		 <c:choose>
		 	<c:when test="${i.tranCode.trim() eq '0' }">
		 		<td>현재 구매가능합니다.</td>
		 	</c:when>
		 	<c:when test="${i.tranCode.trim() eq '1' }">
		 		<td>현재 구매완료했습니다.</td>
		 	</c:when>
		 	<c:when test="${i.tranCode.trim() eq '2' }">
		 		<td>현재 배송중입니다.</td>
		 	</c:when>
		 	<c:otherwise>
		 		<td>배송완료 했습니다.</td>
		 	</c:otherwise>
		 </c:choose>
		 <td>
		 	<a href="/purchase/getPurchase/${i.tranNo }">구매 상세정보 조회</a></td>	 		
		 	<c:if test="${ i.tranCode.trim() eq '1'}">	
		 		<td><a href="/purchase/updateTranCode?tranNo=${i.tranNo }&tranCode=2">배송하기</a></td>
		 	</c:if>
		</td>
		 </tr>
 	</c:forEach>
  </tbody>
</table>

</c:if>
<!--  admin 전용 table End /////////////////////////////////////-->

</div>
  
<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new_purchase.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>