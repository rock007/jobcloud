<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>职位</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap-theme.min.css">
	
	<script type="text/javascript" src="resources/jquery/jquery-1.9.0.js"></script>
    <script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="resources/jquery/jquery.form.js"></script>
    <script type="text/javascript" src="resources/jquery/jquery.atmosphere.js"></script>
    
    <style type="text/css">

      /* Sticky footer styles
      -------------------------------------------------- */

      html,
      body {
        height: 100%;
        /* The html and body elements cannot have any padding or margin. */
      }

      /* Wrapper for page content to push down footer */
      #wrap {
        min-height: 100%;
        height: auto !important;
        height: 100%;
        /* Negative indent footer by it's height */
        margin: 0 auto -60px;
      }

      /* Set the fixed height of the footer here */
      #push,
      #footer {
        height: 60px;
      }
      #footer {
        background-color: #f5f5f5;
      }

      /* Lastly, apply responsive CSS fixes as necessary */
      @media (max-width: 767px) {
        #footer {
          margin-left: -20px;
          margin-right: -20px;
          padding-left: 20px;
          padding-right: 20px;
        }
      }



      /* Custom page CSS
      -------------------------------------------------- */
      /* Not required for template or sticky footer method. */

      .container {
        width: auto;
        max-width: 680px;
      }
      .container .credit {
        margin: 20px 0;
      }

    </style>
</head>
<body>

 <div id="wrap">
 
  <!-- Begin page content -->
      <div class="container">
        <div class="page-header">
          <h1>找工作</h1>
        </div>
        
        <form action="jobs" method="get" class="form-inline">
        
        	<div class="form-group" style="width:80%;">
        		
				<input type="text" name="keyword" class="form-control" placeholder="职位关键字">
				
			</div>
			<button type="submit" class="btn btn-default">试一下</button>
		</form>
		
      </div>
		
      <div id="push"></div>
 </div>
    
	
	<div id="footer">
      <div class="container">
        <p class="muted credit">玄德招聘 <a href="http://xdhire.com">2014</a>.</p>
      </div>
    </div>
    
	<script type="text/javascript">
	    $(document).ready(function() {
	    	
	    });
	</script>	
</body>

</html>


