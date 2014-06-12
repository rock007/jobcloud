<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>职位</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap-theme.min.css">
	
	<script type="text/javascript" src="resources/jquery/jquery-1.9.0.js"></script>
    <script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="resources/jquery/jquery.form.js"></script>
    <script type="text/javascript" src="resources/jquery/jquery.atmosphere.js"></script>

	<link rel="stylesheet" type="text/css" href="resources/jquery/suggest/jquery.suggest.css">
	<script type="text/javascript" src="resources/jquery/suggest/jquery.suggest.js"></script>
</head>
<body>

  
 <div class="navbar" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/jobcloud">找工作</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#"></a></li>
            <li><a href="#about"></a></li>
            <li><a href="#contact"></a></li>
          </ul>
        </div>
      </div>
    </div>


    <div class="container">

      <div class="row row-offcanvas row-offcanvas-right">

        <div class="col-xs-12 col-sm-9">
          <p class="pull-right visible-xs">
            <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>
          </p>
          <div class="well">
            	<form action="jobs" method="get" class="form-inline">
        
        			<div class="form-group" style="width:80%;">
        		
					<input type="text" id="keyword"  name="keyword" value="${form.keyword }" class="form-control" placeholder="职位关键字">
				
				</div>
				<button type="submit" class="btn btn-default">试一下</button>
			</form>
          </div>
         
         <div class="row">
       	
       	 <small> ${result.message } </small>
       	 
			<c:forEach var="j" items="${result.list}">
				<div class="media">
        			<!--  
        			<a class="pull-left" href="#">
          				<img class="media-object" data-src="holder.js/64x64" alt="64x64" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAACm0lEQVR4Xu2Y64upURTGFzLJPVGuo3wg95IyU+JvZ3KJUiKhlOKLEUPuxuWctcrUOc6UebeTZO1PXt699trPftb6ZcvG4/ERHnjIWAB2AJcA94AH7oHATZApwBRgCjAFmAIPrABjkDHIGGQMMgYfGAL8Z4gxyBhkDDIGGYOMwSsosN/voVQqQTgcBq1Wexbxd7OF9XoNdrv9otWuHe+7Ra+GwUajAYPBANLpNMjl8j/Ww828vb2Bz+cDm812kQDXjvdfBcDTrVQqkEgkQKfTna1Vq9VInGAwSALgZ5VKBQaDgd59f3+Hp6cnMBqN9PzTeBcp+s1Lwg44na7FYqEN/j1wsygAlsXz8zOVQK/Xg3a7DalUCpbLJZTLZYjH4ySAlHg3FaDZbEK/3//KIRQKgdVqpeftdkvWDwQCMJ/PQa1Wg8PhoN/QMavVit5xu93g8Xjoe6nxpIog5IDdbgfZbBa8Xi84nU4SotVq0ckqlUooFotk7VgsBljTaPmTAHjSOBdL4eXlBWQyGYjEu4kAo9GI7I2NDzdwPB4hk8kQCT4+PqDb7Z7ldeoDw+EQqtUq/f76+goajQZE4t1EALRwLpeDZDJJJ4nP+XyeThTFOBwOlBdSodPp0DtodRQLT9/v98N0OqUmiDE2m42keOg2qUOoBHDRU4dHe+NmsBlGo9GzfOr1OpWAy+WCQqFAJYKN7+Qak8kEkUhEUjypm8d5wgJgELTzbDYDvV4PZrP5n/mgOxQKBfWEyWRCYqATcHx+fsJisfjC4E/j3VwAkQRuPfcqDrj1JkTWZwH4RohvhPhGiG+ERLrovc9lCjAFmAJMAabAvXdykfyZAkwBpgBTgCkg0kXvfS5TgCnAFGAKMAXuvZOL5M8UeHQK/AKgck6f7dz82QAAAABJRU5ErkJggg==" style="width: 64px; height: 64px;">
        			</a>
        			-->
        			<div class="media-body">
          				<h4 class="media-heading"><a href="${j.url}" target="blank">${j.title}</a> </h4>
          				<small> ${j.companyName}</small>
          				
          				<span class="label label-danger">${j.salary}</span>
          				<blockquote>
          				${j.desc}
          				</blockquote>
          				<span class="label label-default">
          				<c:if test="${j.source=='liepin' }">猎聘 </c:if>
          				<c:if test="${j.source=='lagou' }">拉钩 </c:if>
          				 </span>&nbsp&nbsp<span class="label label-primary">${j.getProps().get("发布日期")}</span>&nbsp&nbsp<span class="label label-info">${j.getProps().get("工作地点")}</span>
        			</div>
        			
      			</div>
			</c:forEach>
         
<ul class="pager">		
<pg:pager url="jobs" items="${result.pageCount}" export="pageOffset,currentPageNumber=pageNumber" isOffset="false" maxPageItems="10"> 
	<c:if test="${not empty form.keyword }">
        <pg:param name="keyword" value="${form.keyword }"/>
    </c:if> 
      	      	
	<pg:index>
        <pg:first>
           <li> <a href="<%=pageUrl%>&pageIndex=<%=pageNumber%>">首页</a></li>
        </pg:first>
        <pg:prev>
            <li><a href="<%=pageUrl%>&pageIndex=<%=pageNumber%>">上一页</a></li>
        </pg:prev>
        <pg:pages>
            <c:choose>
                <c:when test="${pageNumber eq currentPageNumber}">
                    <li class="disabled"><a><%=pageNumber%></a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="<%=pageUrl%>&pageIndex=<%=pageNumber%>"><%=pageNumber%></a></li>
                </c:otherwise>
            </c:choose>
        </pg:pages>
        <pg:next>
            <li><a href="<%=pageUrl%>&pageIndex=<%=pageNumber%>">下一页</a></li>
        </pg:next>
        <pg:last>
            <li><a href="<%=pageUrl%>&pageIndex=<%=pageNumber%>">最后一页</a></li>
        </pg:last>
        
       <li> [共${result.pageCount }条记录]</li>
    </pg:index>
</pg:pager>		
</ul>          		
         </div>
         
         <div class="row">
         
    	<div class="panel panel-default">
  			<div class="panel-body">
    			相关联职位：
    			<c:forEach var="w" items="${words }">
    				<a href="jobs?keyword=${w }">${w }</a>、
    			</c:forEach>
  			</div>
		</div>
    
         </div>
         
        </div><!--/span-->

        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar" role="navigation">
        
        <div class="panel panel-default">
  			<div class="panel-body">
    			热门城市：<a href="jobs?keyword=${form.keyword }&address=上海">上海</a>、<a href="jobs?keyword=${form.keyword }&address=广州">广州</a>、<a href="jobs?keyword=${form.keyword }&address=北京">北京</a>
    			、<a href="jobs?keyword=${form.keyword }&address=杭州">杭州</a>、<a href="jobs?keyword=${form.keyword }&address=南京">南京</a>、<a href="jobs?keyword=${form.keyword }&address=武汉">武汉</a>
  			</div>
		</div>
		

		<div class="panel">
			<h5>热门公司</h5>
  			<ul class="list-unstyled">
  					<c:forEach var="c" items="${companyMap}"> 
						<li>  
						<c:if test="${!(form.company eq c.key) }">
							<a href="jobs?keyword=${form.keyword }&company=${c.key}">${c.key}</a>
						</c:if>
						<c:if test="${ form.company eq c.key }">
							${c.key}
						</c:if>
						 ${c.value}条</li> 
					</c:forEach> 
			</ul>	
	   </div>
	   <div class="panel">
			<h5>薪水范围</h5>
  			<ul class="list-unstyled">
  					<c:forEach var="s" items="${salaryMap}"> 
						<li> 
							
							<c:if test="${!(form.salary eq s.key) }">
								<a href="jobs?keyword=${form.keyword }&salary=${s.key}">${s.key}</a>
							</c:if>
							<c:if test="${ form.salary eq s.key }">
								${s.key}
							</c:if>
							
							  ${s.value}条</li> 
					</c:forEach> 
			</ul>	
	   </div>
	   
	   <div class="panel">
			<h5>最近查询记录 <small><a href="#">清除</a></small></h5>
  			<ul class="list-unstyled">
  					<c:forEach var="k" items="${words_cookie }" >
  						<li> <a href="jobs?keyword={k }">${k }</a></li>
  					</c:forEach>
  					<!--  
  					${cookie.cookie_words.value }
  					-->
			</ul>	
	   </div>
	   
	<!--            
          <div class="list-group">
            <a href="#" class="list-group-item active">net(1078条)</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
          </div>
      -->    
          
        </div><!--/span-->
        
        
      </div><!--/row-->

      <hr>

      <footer>
        <p>&copy; 玄德招聘 2014</p>
      </footer>

    </div><!--/.container-->
    
	<script type="text/javascript">
	    $(document).ready(function() {
	    	
	    	 $("#keyword").suggest("suggest",{
	             onSelect: function() {
	            	 //alert(this.value);
	             }
	           } 
	    	 );   
	    	
	    });
	</script>	
</body>

</html>


