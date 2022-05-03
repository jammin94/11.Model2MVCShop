<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============	
		function fncGetPurchaseList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
		}
		
		
		//============= "�˻�"  Event  ó�� =============	
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>${user.role eq 'admin' ? '���ó��' : '���Ÿ��'}</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				  <input type="radio" id="Desc" name="Order" value="Desc">
					<label for="Desc">���� ������</label>
					<input type="radio" id="Asc" name="Order" value="Asc">
					<label for="Asc">���� ������</label>  
				</form>
	    	</div>   	
		</div>

<!--   user ���� table Start /////////////////////////////////////-->
		
<c:if test="${user.role eq 'user'}">

<div class="row">
     <c:forEach var="i" items= "${list}" varStatus="status" >
	  <div class="col-sm-3 col-md-2">
	    <div class="thumbnail">
	      <a href="/purchase/getPurchase/${i.tranNo}"><img src="/images/uploadFiles/${i.purchaseProd.fileName}"/></a>
	      	
	      <div class="caption">
	        <h3>${i.purchaseProd.prodName }</h3>
	        <h4>${i.purchaseProd.price }��</h4>
	        <h5>��ۻ��� : 
	        <c:choose>
		 	<c:when test="${i.tranCode.trim() eq '0' }">
		 		���� ���Ű����մϴ�.
		 	</c:when>
		 	<c:when test="${i.tranCode.trim() eq '1' }">
		 		���� ���ſϷ��߽��ϴ�.
		 	</c:when>
		 	<c:when test="${i.tranCode.trim() eq '2' }">
		 		���� ������Դϴ�.
		 	</c:when>
		 	<c:otherwise>
		 		��ۿϷ� �߽��ϴ�.
		 	</c:otherwise>
		 </c:choose></h5>

 		<c:if test="${ i.tranCode.trim() eq '1'}">
 			<a href="/purchase/updatePurchase/${i.tranNo }">���� ������ �����ϱ�</a>
 		</c:if>
 		<c:if test="${ i.tranCode.trim() eq '2'}">
 			<a href="/purchase/updateTranCode?tranNo=${i.tranNo }&tranCode=3">�����Ϸ� Ȯ���ϱ�</a>
 		</c:if>
 		
 		</div>
		</div>
	  </div>
	</c:forEach>
</div>

</c:if>

<!--  user ���� table End /////////////////////////////////////-->
		
<!--   admin ���� table Start /////////////////////////////////////-->
      
<c:if test="${user.role eq 'admin'}">

<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">��ǰ��</th>
      <th scope="col">ȸ��ID</th>
      <th scope="col">ȸ����</th>
      <th scope="col">��ȭ��ȣ</th>
      <th scope="col">�����Ȳ</th>
      <th scope="col">��������</th>
      <th scope="col">���ó��</th>
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
		 		<td>���� ���Ű����մϴ�.</td>
		 	</c:when>
		 	<c:when test="${i.tranCode.trim() eq '1' }">
		 		<td>���� ���ſϷ��߽��ϴ�.</td>
		 	</c:when>
		 	<c:when test="${i.tranCode.trim() eq '2' }">
		 		<td>���� ������Դϴ�.</td>
		 	</c:when>
		 	<c:otherwise>
		 		<td>��ۿϷ� �߽��ϴ�.</td>
		 	</c:otherwise>
		 </c:choose>
		 <td>
		 	<a href="/purchase/getPurchase/${i.tranNo }">���� ������ ��ȸ</a></td>	 		
		 	<c:if test="${ i.tranCode.trim() eq '1'}">	
		 		<td><a href="/purchase/updateTranCode?tranNo=${i.tranNo }&tranCode=2">����ϱ�</a></td>
		 	</c:if>
		</td>
		 </tr>
 	</c:forEach>
  </tbody>
</table>

</c:if>
<!--  admin ���� table End /////////////////////////////////////-->

</div>
  
<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>