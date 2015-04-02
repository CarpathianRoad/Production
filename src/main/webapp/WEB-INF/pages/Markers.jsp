<%-- 
    Document   : Partners
    Created on : Jan 13, 2015, 9:59:12 PM
    Author     : kiwi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<t:indexpage>
    <section>
        <div class="s-new markerPageTable">
            <div class="markerLeftDescr">
                <div class="markerPageTitle">${marker.title}</div>
                <div class="markerPageUnderHeading">
                    <div class="markerPageDate">
                        ${marker.date}
                    </div>
                    <div class="markerPageCountry">
                        <img src="${Constants.URL}img/mapControlsImageSelected.png"/>
                        ${marker.country}
                    </div>
                </div>
                <div class="markerPageText">
                    ${marker.textEN}
                </div>
                <c:if test="${fn:length(images[0])!=''}">
                    <script type="text/javascript" src="${Constants.URL}js/article_gallery.js"></script>
                                    <div id="article_slider1_container" style="position: relative; top: 0px; left: 0px; width: 640px; height: 150px; overflow: hidden;">
                                        <div u="slides" style="cursor: move; position: absolute; left: 0px; top: 0px; width: 640px; height: 150px; overflow: hidden;">
                                            <c:forEach items="${images}" var="image" varStatus="loop">
                                                <div onclick="set_main_picture('${Constants.URL}${image}','${loop.index}')">
                                                    <div class="sliderHover">
                                                        <div class="imageHoverMarkerPage"></div><img u="image" src="${Constants.URL}${image}" style="height: 150px"/>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <span u="arrowleft" class="markerPageArrowLeft jssora03l" style="width: 50px; height: 95px; top: 28px; left: 20px;">
                                        </span>
                                        <span u="arrowright" class="markerPageArrowRight jssora03r" style="width: 50px; height: 95px; top: 28px; right: 20px">
                                        </span>
                                    </div>
                                    <div class="article_main_image">
                                        <img id="main_image" src="${Constants.URL}<c:out value="${images[0]}" />" />
                                        <div class="mainImageSliderLine">
                                            <div id="imageCount">1</div>/${fn:length(images)}
                                            &nbsp;&nbsp;
                                                ${article.title} Gallery
                                        </div>
                                    </div>
                </c:if>
                                    <div class="markerPageBottomLine"></div>
                                    <div class="markerPageSocial">
                                        <div class="fbMarker markerPageSocialHover">
                                            <div class="markerPageSocialIcon">
                                                <img src="${Constants.URL}img/fb_icon_marker.png">
                                            </div>
                                            <div class="markerPageSocialNumber">25</div>
                                        </div>
                                        <div class="twMarker markerPageSocialHover">
                                            <div class="markerPageSocialIcon">
                                                <img src="${Constants.URL}img/tw_icon_marker.png">
                                            </div>
                                            <div class="markerPageSocialNumber">117</div>
                                        </div>
                                    </div>
            </div>
            <div class="markerRightDescr">
                <div class="otherNewsHeading">OTHER MARKERS</div>
                <c:forEach items="${articles}" var="item">
                    <div class="s-cellFullArticle slide">
                    <div class="s-block">
                        <div class="newsImage">
                            <a href="${Constants.URL}map/markers/${item.id}">
                                <div class="imageHover">
                                    <div class="imageHoverDate">
                                        ${item.date}
                                    </div>
                                    <div class="imageHoverCountry">
                                        <div class="newsCountryText">${item.country}</div><img src="${Constants.URL}img/newsImageHover.png">
                                    </div>
                                </div>
                                <img src="${Constants.URL}${item.image}" />
                            </a>
                        </div>

                        <img class="newsImageUnderline" src="${Constants.URL}img/newsLine.png" alt="image">
                        <div class="newsName"><a href="${Constants.URL}map/markers/${item.id}">${item.title}</a></div>
                        <a href="${Constants.URL}map/markers/${item.id}"><div class="newsText">${item.textEN}</div></a>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
    </section>
</t:indexpage>