<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/error.css">
	<title>쉼표,</title>

	</head>
<body>


<div class="error_container">
    <div class="error_block">
        
  
         <h1><strong>404</strong></h1>

        <h3>Oops... Page Not Found !</h3>
        <br>
        <div id="try"><p><strong> using the button below to go to main page of the site</p></strong></div>

        <a href="http://localhost:8090/comma/"><input type="button" class="error_btn" value="Go To Main Page"></a>

    </div>
 </div>

</body>
</html>

  