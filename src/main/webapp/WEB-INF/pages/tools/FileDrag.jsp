<%--
	Document   : FileDrag
	Created on : Aug 3, 2015, 4:01:49 PM
	Author 	: kiwi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="Constants" class="ua.aits.Carpath.functions.Constants" scope="session"/>
<!DOCTYPE html>
<html>
	<head>
    	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    	<title>JSP Page</title>
    	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
    	<link href="${Constants.URL}css/bootstrap.min.css" rel="stylesheet" />
    	<link href="${Constants.URL}css/style.css" rel="stylesheet" />
    	<link href="${Constants.URL}css/admin.css" rel="stylesheet" />
    	<link rel="stylesheet" href="${Constants.URL}archive/css/dropzone.css">
    	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
    	<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
    	<style>
        	body{
            	margin: 10px;
        	}
        	form {
            	height: 475px;
        	}
        	.dz-message span {
            	font-size: 36px;
            	color: #5cb85c;
        	}
    	</style>
	</head>
	<body>
     	<div>
<form action="<c:url value="/archive/do/uploadimage" />" class="dropzone"  id="my-awesome-dropzone">
        	<input type="hidden" name="path" value="${folder}/images" />
        	<input type="file" name="file" style="display:none" />
    	</form>
</div>
	</body>
	<script src="${Constants.URL}archive/js/plugins/dropzone.js"></script>
	<script>
    	$(document).ready(function () {
        	$("#my-awesome-dropzone").dropzone({
            	url: "<c:url value="/system/archive/do/uploadimage" />",
            	addRemoveLinks: true,
            	init: function () {
	this.on("complete", function (file) {
  	if (this.getUploadingFiles().length === 0 && this.getQueuedFiles().length === 0) {
    	completeAjaxCall("${folder}/images/"+$(".dz-filename span").html());
  	}
	});
  }
        	});
       	 
    	});
    	function completeAjaxCall(path){
    	console.log(path);
                	window.opener.CKEDITOR.tools.callFunction("${num}", ""+"${Constants.URL}"+ path +"","");
                	window.opener.imageInserted();
                	window.close();
    	}
	</script>  
    
</html>