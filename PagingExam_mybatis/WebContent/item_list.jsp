<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
a:link{
	/*방문하지 않은 링크 설정.*/
	text-decoration:none; /*밑줄 안나오도록 처리.*/
	color:green;
}
a:visited{
	/*방문한 링크 설정*/
	text-decoration: none;
	color:green;
}
a:hover{
	/*마우스 포인터가 올라간 시점의 설정.*/
	text-decoration: underline;
	color:red;
}
a:active{
	/*마우스를 링크에 클릭하는 시점*/
	color:blue;
}
table, td{
	border: 1px solid gray;
}
table{
	border-collapse: collapse;
	width: 500px;
}
td{
	padding: 10px;
}
</style>
</head>
<body>
<h2>Item 목록</h2>
<table>
	<thead>
		<tr>
			<td>NO</td>
			<td>아이템</td>
		</tr>
	</thead>
	<tbody>
		
		<c:forEach items="${requestScope.list }" var="item">
			<tr>
				<td>${item.no }</td>
				<td>${item.item }</td>
			</tr>
		</c:forEach>
		
		
	</tbody>
</table>

<p>
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	
	<a href="${initParam.rootPath }/itemList?page=1">[첫페이지]</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup }">
			<!-- 이전 페이지 그룹이 있다면 -->
			<a href="${initParam.rootPath }/itemList?page=${requestScope.pageBean.beginPage - 1}">◀</a>
		</c:when>
		<c:otherwise>
			◀
		</c:otherwise>
	</c:choose>
	
	
	
	
	
	<!-- 
		현재 page가 속한 page 그룹내의 페이지들 링크.
		현재 pageGroup의 시작page ~ 끝 page
	 -->
	 <!-- 만약에 p가 현재페이지면 링크처리를 하지 않고 page가 현재페이지가 아니라면 링크처리. -->
	
	<c:forEach begin="${requestScope.pageBean.beginPage }" end="${requestScope.pageBean.endPage }" var="page"> <!-- var는 1~10 반복할 구문을 찍어야하기 때문에 저장할 변수가 필요하다. -->
		<c:choose>
			<c:when test="${requestScope.pageBean.page != page }">
			<!-- 현재 페이지가 아니라면 -->
			<a href="${initParam.rootPath}/itemList?page=${page }">${page }</a>
			</c:when>
			<c:otherwise>
			[${page }]&nbsp;&nbsp;   <!-- &nbsp; : 공백 -->
			</c:otherwise>
		</c:choose>
	</c:forEach>
	
	
	
	<!-- 
		다음페이지 그룹으로 이동
		만약에 다음페이지 그룹이 있으면 링크 처리 없으면 화살표만 나오도록 처리
	 -->
	
	<c:choose>
		<c:when test="${requestScope.pageBean.nextPageGroup }">
			<a href="${initParam.rootPath }/itemList?page=${requestScope.pageBean.endPage + 1}">▶</a>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	
	
	
	
	
	
	<!-- 마지막 페이지로 이동 -->

	<a href="${initParam.rootPath }/itemList?page=${requestScope.pageBean.totalPage}">[마지막 페이지]</a>




</p>
</body>
</html>




