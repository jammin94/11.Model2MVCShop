<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script>
function fncGetPurchaseList(currentPage){
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();	
}

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">${user.role eq 'admin' ? '���ó��' : '���Ÿ��'} </td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			
			 <c:choose>
		 		<c:when test="${search.searchCondition =='0' || search.searchCondition == null}">
		 			<option value="0" selected>��ǰ��ȣ</option>
		 			<option value="1">��ǰ��</option>
		 			<option value="2">��ǰ����</option>
		 		</c:when>
		
		 		<c:when test="${search.searchCondition =='1'}">
		 			<option value="0">��ǰ��ȣ</option>
		 			<option value="1" selected>��ǰ��</option>
		 			<option value="2">��ǰ����</option>
		 		</c:when>
		 		
		 		<c:when test="${search.searchCondition =='2'}">
		 			<option value="0">��ǰ��ȣ</option>
		 			<option value="1">��ǰ��</option>
		 			<option value="2" selected>��ǰ����</option>
		 		</c:when>

			 </c:choose>
			 
			</select>
			<input 	type="text" name="searchKeyword"  value="${! empty search.searchKeyword ? search.searchKeyword : "" }"
							class="ct_input_g" style="width:200px; height:19px" >
		</td>
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetPurchaseList(1);">�˻�</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			
			</table>
			<td align="left">
		<input type="radio" id="Desc" name="Order" value="Desc">
		<label for="Desc">���� ������</label>
		<input type="radio" id="Asc" name="Order" value="Asc">
		<label for="Asc">���� ������</label>
	</td>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü  ${resultPage.totalCount} �Ǽ�,	���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">��ǰ��</td>
		<td class="ct_line02"></td>
		<c:if test="${user.role eq 'admin'}">
			<td class="ct_list_b" width="150">ȸ��ID</td>
			<td class="ct_line02"></td>
		</c:if>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" colspan="3">��������</td>
		<td class="ct_line02" ></td>
	</tr>
	<tr>
		<td colspan="17" bgcolor="808285" height="1"></td>
	</tr>

	<c:forEach var="i" items= "${list}" varStatus="status" >

	
		<tr class="ct_list_pop">
			<td align="center">
				${status.count }
			</td>
			<td></td>
			<td><a href="/product/getProduct/${i.purchaseProd.prodNo }">${i.purchaseProd.prodNo }</a></td>
			<c:if test="${user.role eq 'admin'}">
			<td></td>
				<td align="left" >
				<a href="/user/getUser?userId=${i.buyer.userId }">${i.buyer.userId }</a>
				</td>
			</c:if>
			<td align="left"></td>
			<td align="left">${i.receiverName }</td>
			<td></td>
			<td align="left">${i.receiverPhone }</td>
			<td></td>
			 
			 <c:choose>
			 	<c:when test="${i.tranCode.trim() eq '0' }">
			 		<td align="left">���� ���Ű����մϴ�.</td>
			 	</c:when>
			 	<c:when test="${i.tranCode.trim() eq '1' }">
			 		<td align="left">���� ���ſϷ��߽��ϴ�.</td>
			 	</c:when>
			 	<c:when test="${i.tranCode.trim() eq '2' }">
			 		<td align="left">���� ������Դϴ�.</td>
			 	</c:when>
			 	<c:otherwise>
			 		<td align="left">��ۿϷ� �߽��ϴ�.</td>
			 	</c:otherwise>
			 </c:choose>
			<td>
				
			</td>
			<td align="left">
			 	<c:if test="${user.role eq 'user'}">
			 		<td align="left" >
			 		<a href="/purchase/getPurchase/${i.tranNo }">���� ������ ��ȸ</a>
			 		</td>
			 		<c:if test="${ i.tranCode.trim() eq '1'}">
			 		<td align="left" >
			 		  <a href="/purchase/updatePurchase/${i.tranNo }">���� ������ �����ϱ�</a>
			 		</td>
			 		</c:if>
			 		<c:if test="${ i.tranCode.trim() eq '2'}">
			 		<td align="left" >
			 		  <a href="/purchase/updateTranCode?tranNo=${i.tranNo }&tranCode=3">�����Ϸ� Ȯ���ϱ�</a>
			 		 </td>
			 		</c:if>
			 	</c:if>
			 		
			 	<c:if test="${ i.tranCode.trim() eq '1' && user.role eq 'admin'}">
			 		<td align="left" >
			 		 <a href="/purchase/updateTranCode?tranNo=${i.tranNo }&tranCode=2">����ϱ�</a>
			 		 </td>
			 	</c:if>
			 	
			</td>
	</c:forEach>
	</tr>
	<tr>
		<td colspan="17" bgcolor="D6D7D6" height="1"></td>
	</tr>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">

		<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			<c:if test="${resultPage.currentPage>resultPage.pageUnit }">
				<a href="javascript:fncGetPurchaseList('${resultPage.beginUnitPage-1}')">����</a>
			</c:if>
			
			<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage }" varStatus="status" >
				<a href="javascript:fncGetPurchaseList('${i }');">${i }</a> 
			</c:forEach>
			
			<c:if test="${resultPage.endUnitPage<resultPage.maxPage }">
				<a href="javascript:fncGetPurchaseList('${resultPage.endUnitPage+1}')">����</a>
			</c:if>
			
		</td>
	</tr>
</table>


</form>

</div>

</body>
</html>