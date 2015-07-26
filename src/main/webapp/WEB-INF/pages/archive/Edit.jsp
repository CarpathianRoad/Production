<%-- 
    Document   : Edit
    Created on : Jul 22, 2015, 7:59:53 PM
    Author     : kiwi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<t:archive_page>
    <script src="${Constants.URL}js/ckeditor/ckeditor.js"></script>
    <div class="margintop20">
        <h4>Add article</h4>
	<form action="${Constants.URL}archive/do/updatedata.do" name="addArticleForm" id="addForm" method="POST" type="multipart/form-data">
            <input type="hidden" class="form-control" id="auth" name="author" value="<c:out value="${sessionScope.user.user_name}"/>">
            <input type="hidden" class="form-control" name="category" value="${article.article_category}">
            <input type="hidden" class="form-control" name="id" value="${article.article_id}">
            <div class="row add-row">
                <div class="col-lg-12 margintop30 field">
                    <label for="tlt">Article title <span class="red-star">*</span></label>
                    <br/>
                    <div class="btn-group lang-switch-title" role="group" aria-label="...">
                        <button type="button" id="titleEN" class="btn btn-default active">In English</button>
                        <button type="button" id="titleUA" class="btn btn-default">In Ukrainian</button>
                        <button type="button" id="titleHU" class="btn btn-default disabled">In Hungarian</button>
                        <button type="button" id="titleSK" class="btn btn-default disabled">In Slovak</button>
                        <button type="button" id="titleRO" class="btn btn-default disabled">In Romanian</button>
                    </div>
                </div>
                <div class="col-lg-6 margintop10 field">
                    <input type="text" name="titleEN" class="form-control input-title-lang" lang="titleEN" id="tlt" value="${article.article_title_en}" maxlength="55">
                    <input type="text" name="titleUA" class="form-control input-title-lang" lang="titleUA" id="tlt" value="${article.article_title_ua}" maxlength="55">
                    <input type="text" name="titleHU" class="form-control input-title-lang" lang="titleHU" id="tlt"  maxlength="55">
                    <input type="text" name="titleSK" class="form-control input-title-lang" lang="titleSK" id="tlt"  maxlength="55">
                    <input type="text" name="titleRO" class="form-control input-title-lang" lang="titleRO" id="tlt"  maxlength="55">
                    <div class="validation" id="textValidation"></div>
                </div>
            </div>
            <hr>
            <div class="row add-row">
                <div class="col-lg-12 margintop30 field">
                    <label for="tlt">Article text <span class="red-star">*</span></label><br/>
                    <div class="btn-group lang-switch-text" role="group" aria-label="...">
                        <button type="button" id="textEN" class="btn btn-default active">In English</button>
                        <button type="button" id="textUA" class="btn btn-default">In Ukrainian</button>
                        <button type="button" id="textHU" class="btn btn-default disabled">In Hungarian</button>
                        <button type="button" id="textSK" class="btn btn-default disabled">In Slovak</button>
                        <button type="button" id="textRO" class="btn btn-default disabled">In Romanian</button>
                    </div>
                </div>
                <div class="col-lg-12 margintop10 field textareas">
                    <div class="ck-data-box" id="CKdata"></div>
                        <div lang="textEN" class="textarea-msg"><textarea name="textEN" id="editorEN" rows="20" cols="80" class="input-block-level">${article.article_text_en}</textarea></div>
                        <div lang="textUA" class="textarea-msg"><textarea name="textUA" id="editorUA" rows="20" cols="80" class="input-block-level">${article.article_text_ua}</textarea></div>
                        <div lang="textHU" class="textarea-msg"><textarea name="textHU" id="editorHU" rows="20" cols="80" class="input-block-level"></textarea></div>
                        <div lang="textSK" class="textarea-msg"><textarea name="textSK" id="editorSK" rows="20" cols="80" class="input-block-level"></textarea></div>
                        <div lang="textRO" class="textarea-msg"><textarea name="textRO" id="editorRO" rows="20" cols="80" class="input-block-level"></textarea></div>
                        <div class="validation"></div>
                </div>
            </div>
            <hr>
        </form>
        <div class="row add-row">
            <div class="col-lg-12 margintop30 field">
                <label for="tlt">Article files</label><br/>
            </div>
        </div>
        <form action="/file-upload" class="dropzone" id="my-awesome-dropzone">
            <input type="file" name="file" style="display:none" />
        </form>
        <p>
            <button class="btn btn-warning margintop30 marginbottom30" id="sudmitData" type="submit">+ Save changes</button>
        </p>
    </div>
</t:archive_page>
<script> 
    $(document).ready(function () { 
        var currentLang = $(".lang-switch-text button.active").attr("id");
        $(".textareas .textarea-msg[lang='"+currentLang+"']").show();
        var currentLangT = $(".lang-switch-title button.active").attr("id");
        $(".input-title-lang[lang='"+currentLangT+"']").show();
        initCKE();
    });
    
    $(".lang-switch-text button").click(function(){
        $(".lang-switch-text button").removeClass("active");
        $(this).addClass("active");
        var currentLang = $(this).attr("id");
        $(".textareas .textarea-msg").hide();
        $(".textareas .textarea-msg[lang='"+currentLang+"']").show();
    });
    $(".lang-switch-title button").click(function(){
        $(".lang-switch-title button").removeClass("active");
        $(this).addClass("active");
        var currentLangT = $(this).attr("id");
        $(".input-title-lang").hide();
        $(".input-title-lang[lang='"+currentLangT+"']").show();
    });
    
    $("#sudmitData").click(function(){
        $("div.validation").html('');
        var isValidate = true;

        if(isValidate) {
            $("#addForm").submit();
        }
    });
    
    function initCKE() {
        CKEDITOR.replace('editorEN', {
            filebrowserBrowseUrl : '${Constants.URL}tools/fileManager',
            filebrowserUploadUrl : '${Constants.URL}tools/fileManager',
            filebrowserImageBrowseUrl : '${Constants.URL}tools/fileManager',
            filebrowserImageUploadUrl : '${Constants.URL}tools/fileManager',
            filebrowserWindowWidth  : 800,
            filebrowserWindowHeight : 500
        });
        CKEDITOR.replace('editorUA', {
            filebrowserBrowseUrl : '${Constants.URL}tools/fileManager',
            filebrowserUploadUrl : '${Constants.URL}tools/fileManager',
            filebrowserImageBrowseUrl : '${Constants.URL}tools/fileManager',
            filebrowserImageUploadUrl : '${Constants.URL}tools/fileManager',
            filebrowserWindowWidth  : 800,
            filebrowserWindowHeight : 500
        });
        CKEDITOR.replace('editorHU', {
            filebrowserBrowseUrl : '${Constants.URL}tools/fileManager',
            filebrowserUploadUrl : '${Constants.URL}tools/fileManager',
            filebrowserImageBrowseUrl : '${Constants.URL}tools/fileManager',
            filebrowserImageUploadUrl : '${Constants.URL}tools/fileManager',
            filebrowserWindowWidth  : 800,
            filebrowserWindowHeight : 500
        });
        CKEDITOR.replace('editorSK', {
            filebrowserBrowseUrl : '${Constants.URL}tools/fileManager',
            filebrowserUploadUrl : '${Constants.URL}tools/fileManager',
            filebrowserImageBrowseUrl : '${Constants.URL}tools/fileManager',
            filebrowserImageUploadUrl : '${Constants.URL}tools/fileManager',
            filebrowserWindowWidth  : 800,
            filebrowserWindowHeight : 500
        });
        CKEDITOR.replace('editorRO', {
            filebrowserBrowseUrl : '${Constants.URL}tools/fileManager',
            filebrowserUploadUrl : '${Constants.URL}tools/fileManager',
            filebrowserImageBrowseUrl : '${Constants.URL}tools/fileManager',
            filebrowserImageUploadUrl : '${Constants.URL}tools/fileManager',
            filebrowserWindowWidth  : 800,
            filebrowserWindowHeight : 500
        });
        
        var obj = $("#cke_120_fileInput").contents().find(".returnImage");
         obj.click("click", function (e) {
            $("#cke_71_textInput").val("s2as1");
        });
    }
</script>
<script src="${Constants.URL}archive/js/plugins/dropzone.js"></script>