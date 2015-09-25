<%-- 
    Document   : routesList
    Created on : Jan 17, 2015, 11:50:24 PM
    Author     : kiwi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<t:indexpage>
    <script>
        var files = [];
        var types = [];
        var categories = [];
        var countries = [];
    </script>
    <style>
        @media (max-device-width: 780px){
            .newsImage{
                display: none;
            }
            .newsImageUnderline{
                display: none;
            }
        }
        @media (max-width: 360px){
            .newsImage{
                display: none;
            }
            .newsImageUnderline{
                display: none;
            }
        }
    </style>
    <div class="s-new widthClass">
        <input type="hidden" id="page_type" value="routes" />
        <input type="hidden" id="last_item" value="9" />
        <input type="hidden" id="contstants" value="${Constants.URL}" />
        <input type="hidden" id="lan" value="${lan}" />
        <input type="hidden" id="count" value="${count}" />
        <div class="s-new markerPageTable">
            <div class="breadcrumbsMarker">
                <div class="countriesFilter countriesFilterRoute">
                    <input type="hidden" id="selected_country" value="all"/>
                    <div class="filterRoutesFin"><a id="all" onclick="countryFilter('all');" class="selected_country" >${titles.countryALL}</a></div>
                    <div class="filterRoutesFin"><a id="Ukraine" onclick="countryFilter('Ukraine');" >${titles.countryUA}</a></div>
                    <div class="filterRoutesFin"><a id="Poland" onclick="countryFilter('Poland');" >${titles.countryPL}</a></div>
                    <div class="filterRoutesFin"><a id="Hungary" onclick="countryFilter('Hungary');" >${titles.countryHU}</a></div>
                    <div class="filterRoutesFin"><a id="Romania" onclick="countryFilter('Romania');" >${titles.countryRO}</a></div>
                    <div class="filterRoutesFin"><a id="Slovakia" onclick="countryFilter('Slovakia');" >${titles.countrySK}</a></div>
                </div>
                <div class="tripMethod">
                    <input type="hidden" id="selected_type" value="all_type"/>
                    <div id="5" class="tripFilterText"><a onclick="change_routes_type('5');">${titles.routeWAT}</a></div>
                    <div id="4" class="tripFilterText"><a onclick="change_routes_type('4');">${titles.routeHOR}</a></div>
                    <div id="3" class="tripFilterText"><a onclick="change_routes_type('3');">${titles.routeSKI}</a></div>
                    <div id="2" class="tripFilterText"><a onclick="change_routes_type('2');">${titles.routeBIC}</a></div>
                    <div id="1" class="tripFilterText"><a onclick="change_routes_type('1');">${titles.routeWAL}</a></div>
                    <div id="all_type" class="tripFilterText selectedCountryTrip"><a onclick="change_routes_type('all_type');">${titles.routeALL}</a></div>
                </div>
            </div>
        </div>
            <div class="all_news" id="routesList">        
                <c:forEach items="${routesList}" var="route" varStatus="loop">
                    <div class="s-cell" id="routeBlock${loop.index}">
                        <div class="s-block newsHeight">
                            <div class="newsImage">
                                <a href="${Constants.URL}routes/${route.id}">
                                    <div class="imageHover">
                                        <div class="imageHoverDate">
                                            ${route.date}
                                ${route.file}
                                        </div>
                                        <div class="imageHoverCountry">
                                            <div class="newsCountryText">${route.public_country}</div><img src="${Constants.URL}img/newsImageHover.png">
                                        </div>
                                        <div class="routeType" id="type${loop.index}"></div>
                                        <div class="routeType" id="category${loop.index}"></div>
                                    </div>
                                    <div class="routesListMap" id="map${loop.index}"></div>
                                </a>
                            </div>
                            <img class="newsImageUnderline" src="${Constants.URL}img/newsLine.png">
                            <div class="news_text_box">
                                <div class="news_title"><a href="${Constants.URL}routes/${route.id}">${route.title}</a></div>
                                <a href="${Constants.URL}routes/${route.id}">
                                    <div class="news_text">${route.textUA}</div>
                                </a>
                            </div>
                        </div>
                    </div>   
                    <script>files.push("${route.file}");</script>
                    <script>types.push("${route.type}");</script>
                    <script>categories.push("${route.category}");</script>
                    <script>countries.push("${route.public_country}");</script>
                </c:forEach>
            </div>
                 <div class="loading_block">
                    <img src="${Constants.URL}img/status.gif" />
                </div>
    </div>
                        
				<div style="display:none;" id="pagination">
					<span class="all">Page 1 of 3</span>
					<span class="current">1</span>
					<a href="#" class="inactive">2</a>
					<a href="#" class="inactive">3</a>
				</div>
        <script>
            
            var countRoute = 0;
            var map = [];
            var height = [];  
            var length = [];
            var xCoord = [];
            var yCoord = [];
            var points = [];
            var route;
            var center;
            var mapStyles = [{"featureType":"landscape","elementType":"labels","stylers":[{"visibility":"off"}]},
            {"featureType":"transit","elementType":"labels","stylers":[{"visibility":"off"}]},
            {"featureType":"poi","elementType":"labels","stylers":[{"visibility":"off"}]},
            {"featureType":"water","elementType":"labels","stylers":[{"visibility":"off"}]},
            {"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"stylers":[{"hue":"#00aaff"},{"saturation":-100},{"gamma":2.15},{"lightness":12}]},
            {"featureType":"road","elementType":"labels.text.fill","stylers":[{"visibility":"on"},{"lightness":24}]},
            {"featureType":"road","elementType":"geometry","stylers":[{"lightness":57}]}];
        
            for(var n = 0; n < types.length; n++){
                switch(types[n]){
                    case "1":
                        $('#type'+n).html('Walking route');
                        break;
                    case "2":
                        $('#type'+n).html('Bicycle route');
                        break;
                    case "3":
                        $('#type'+n).html('Ski route');
                        break;
                    case "4":
                        $('#type'+n).html('Horses route');
                        break;
                    case "5":
                        $('#type'+n).html('Water route');
                        break;
                }
                switch(categories[n]){
                    case "4":
                        $('#category'+n).html('International tourist road (E or R)');
                        break;
                    case "1":
                        $('#category'+n).html('National tourist road');
                        break;
                    case "2":
                        $('#category'+n).html('Regional tourist road');
                        break;
                    case "3":
                        $('#category'+n).html('District tourist roade');
                        break;
                    case "0":
                        $('#category'+n).html('Local (excursion) tourist road');
                        break;
                }
            }
            build_route(files);
            function build_route(files_array)
                {
                    countRoute = 0;           
                    for(var count = 0; count < '${fn:length(routesList)}'; count++){
                            if (window.XMLHttpRequest){
                                xmlhttp=new XMLHttpRequest();
                            }
                            else{
                                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                            }
                            xmlhttp.open("GET","${Constants.URL}routes/"+files_array[count],false);
                            xmlhttp.send();
                            xmlDoc=xmlhttp.responseXML;
                            $.ajax({
                                type: "GET",
                                url: "${Constants.URL}routes/"+files_array[count],
                                dataType: "xml",
                                success: parseXml
                            });
                    }   
                console.log(files);
                }
                function parseXml(xml){
                        height = [];  
                        length = [];
                        xCoord = [];
                        yCoord = [];
                        points = [];
                        route = null;
                        center = null;
                    $(xml).find("trkpt").each(function(){
                        height.push($(this).find("ele").text());
                    });
                    $(xml).find("trkpt").each(function(){
                        xCoord.push($(this).attr("lat"));
                    });
                    $(xml).find("trkpt").each(function(){
                        yCoord.push($(this).attr("lon"));
                    });
                    var styledMap = new google.maps.StyledMapType(mapStyles,
                        {name: "Styled Map"});
                    var mapOptions = {
                      zoom: 11,
                      center: getCenter(),
                      //center: latlng,
                      mapTypeId: google.maps.MapTypeId.SATELLITE,
                      disableDefaultUI: true,
                      mapTypeControlOptions: {
                        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
                      }
                    };
                    map[countRoute] = new google.maps.Map(document.getElementById("map"+countRoute),
                        mapOptions);
                    map[countRoute].mapTypes.set('map_style', styledMap);
                    map[countRoute].setMapTypeId('map_style');
                for (var i = 0; i < (height.length); i++) { 
                    if(i==0){
                        var p1 = new google.maps.LatLng(xCoord[i],yCoord[i]);
                        var p2 = new google.maps.LatLng(xCoord[i+1],yCoord[i+1]);
                        points.push(p1);
                    }
                    else if(i==height.length-1){
                        length.push(length[i-1]);
                    }
                    else{
                        var p1 = new google.maps.LatLng(xCoord[i],yCoord[i]);
                        var p2 = new google.maps.LatLng(xCoord[i+1],yCoord[i+1]);
                        points.push(p1);
                    }
                }
                route = new google.maps.Polyline({
                    path: points,
                    geodesic: true,
                    strokeColor: '#FF9900',
                    strokeOpacity: 1.0,
                    strokeWeight: 2
		});
		route.setMap(map[countRoute]);
                countRoute ++;
                }
            files = [];
            function getCenter(){
                var minLat = 0;
                var maxLat = 0;
                var minLon = 0;
                var maxLon = 0;
                for (var j = 0; j < xCoord.length; j++){
                    if (j == 0){
                        minLat = xCoord[j];
                        maxLat = xCoord[j];
                        minLon = yCoord[j];
                        maxLon = yCoord[j];
                    }
                    else{
                        if (minLat <= xCoord[j]){
                            minLat = xCoord[j];
                        }
                        if (maxLat >= xCoord[j]){
                            maxLat = xCoord[j];
                        }
                        if (minLon <= yCoord[j]){
                            minLon = yCoord[j];
                        }
                        if (maxLon >= yCoord[j]){
                            maxLon = yCoord[j];
                        }
                    }
                }
                return (new google.maps.LatLng((parseFloat(minLat)+parseFloat(maxLat))/2, (parseFloat(minLon)+parseFloat(maxLon))/2));
            }
            
            function countryFilter(country){
                for(var n = 0; n < types.length; n++){
                    var selected_country = jQuery("#selected_country").val();
                    jQuery( "#"+selected_country).removeClass( "selected_country" );
                    jQuery( "#"+country ).addClass( "selected_country" );
                    jQuery("#selected_country").val(country);
                    jQuery("#last_item").val("9");
                    if(countries[n]!=country){
                        $('#routeBlock'+n).css('display','none');
                    }else{
                        $('#routeBlock'+n).css('display','block');
                    }
                    if(country=='all')
                        $('#routeBlock'+n).css('display','block');
                }
            }
        </script>
</t:indexpage>