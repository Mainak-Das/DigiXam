<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error!</title>
    <link rel="stylesheet" href="Assets/css/error.css">
</head>
<body>
    <div class="login__img">
        <img src="Assets/404 Error.gif" alt="gif" style="width: 25rem; height: auto;">
    </div>
    <div class="wrapper">
        <h1>Page Not Found</h1>
        
        <a href="<%=request.getContextPath()%>/login" class="btn" Style="border-radius: 25px; width: 20rem; text-align: center">Go to Homepage</a>
        <p class="copyRights">&copy; 2022 DigiXam</p>
    </div>
</body>
</html>