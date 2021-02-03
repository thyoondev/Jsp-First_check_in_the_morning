<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%
	xmlDao dao = new xmlDao();
//parsing할 url 지정(API 키 포함해서)
String url = "http://openapitraffic.daejeon.go.kr/api/rest/arrive/getArrInfoByUid?serviceKey=ed9v9eIRGelE0CM5aVlO9igCLIt19%2F9LwOeXm4ReIf5St9Swn9jyZa%2FRMtNiac9ELFwvvoD8d9q3%2FYKpzHlWsA%3D%3D&arsId=22430";

DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
Document doc = dBuilder.parse(url);

// root tag 
doc.getDocumentElement().normalize();
//System.out.println("Root element: " + doc.getDocumentElement().getNodeName()); // Root element: result

//파싱할 tag
NodeList nList = doc.getElementsByTagName("itemList");
//System.out.println("파싱할 리스트 수 : "+ nList.getLength());  // 파싱할 리스트 수 :  5

/* for(int temp = 0; temp < nList.getLength(); temp++){		
	Node nNode = nList.item(temp);
	if(nNode.getNodeType() == Node.ELEMENT_NODE){
				
		Element eElement = (Element) nNode;
		System.out.println("######################");
		//System.out.println(eElement.getTextContent());
		System.out.println("차량번호  : " + dao.getTagValue("ROUTE_NO", eElement));
		System.out.println("종점  : " + dao.getTagValue("DESTINATION", eElement));
		System.out.println("도착예정시간(분) : " + dao.getTagValue("EXTIME_MIN", eElement) + "분");
		System.out.println("잔여 정류장 수  : " + dao.getTagValue("STATUS_POS", eElement) + "개");
	}	// for end
}	// if end */
%>
<!DOCTYPE html>
<html lang="">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=no" />
<title>Check in the morning</title>
<meta name="author" content="thyoondev" />
<meta name="description" content="날씨 및 버스 도착 조회" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/main.css" />
<link href="css/uicons-regular-rounded.css" rel="stylesheet" />
<link href="css/weather-icons.css" rel="stylesheet" />
<link rel="icon" type="image/x-icon" href="" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">
	//툴바 감추기
	window.addEventListener("load", function() {
		setTimeout(scrollTo, 0, 0, 1);
	}, false);
</script>
<meta name="apple-mobile-web-app-capable" content="yes" />
<script>
	//        var latitude = "";
	//        var longitude = "";
	//        navigator.geolocation.getCurrentPosition(function(pos) {
	//            latitude = pos.coords.latitude;
	//            longitude = pos.coords.longitude;
	//        });
	//function goWeather(){
	//        var url = 'http://api.openweathermap.org/data/2.5/weather?lat='+latitude+'&lon='+longitude+'&appid=9baac3369dd75739c16d992d23f0b417&lang=kr&units=metric';

	var locationName = "Daejeon";
	var url = "http://api.openweathermap.org/data/2.5/weather?q="
			+ locationName
			+ "&appid=9baac3369dd75739c16d992d23f0b417&lang=kr&units=metric";

	fetch(url)
			.then(function(response) {
				return response.json();
			})
			.then(
					function(json) {
						console.log(json);
						const place = json.name; //도시명
						const temp = json.main.temp.toFixed(0) + "°"; //현재온도
						const tempMax = "최고 : " + json.main.temp_max + "°"; //최고기온
						const tempMin = "최저 : " + json.main.temp_min + "°"; //최저기온
						const humidity = "습도 : " + json.main.humidity + "%"; //습도
						const stat = json.weather[0].description; //날씨 설명
						const iconCode = json.weather[0].icon; //날씨 아이콘 코드

						var weatherIcon = "";
						if (iconCode == "01d") {
							weatherIcon = "wi wi-day-sunny";
						} else if (iconCode == "02d") {
							weatherIcon = "wi wi-day-cloudy";
						} else if (iconCode == "03d") {
							weatherIcon = "wi wi-cloud";
						} else if (iconCode == "04d") {
							weatherIcon = "wi wi-cloudy";
						} else if (iconCode == "09d") {
							weatherIcon = "wi wi-showers";
						} else if (iconCode == "10d") {
							weatherIcon = "wi wi-rain";
						} else if (iconCode == "11d") {
							weatherIcon = "wi wi-lightning";
						} else if (iconCode == "13d") {
							weatherIcon = "wi wi-day-snow";
						} else if (iconCode == "50d") {
							weatherIcon = "wi wi-dust";
						}

						if (iconCode == "01n") {
							weatherIcon = "wi wi-night-clear";
						} else if (iconCode == "02n") {
							weatherIcon = "wi wi-night-cloudy";
						} else if (iconCode == "03n") {
							weatherIcon = "wi wi-cloud";
						} else if (iconCode == "04n") {
							weatherIcon = "wi wi-cloudy";
						} else if (iconCode == "09n") {
							weatherIcon = "wi wi-showers";
						} else if (iconCode == "10n") {
							weatherIcon = "wi wi-rain";
						} else if (iconCode == "11n") {
							weatherIcon = "wi wi-lightning";
						} else if (iconCode == "13n") {
							weatherIcon = "wi wi-night-snow";
						} else if (iconCode == "50n") {
							weatherIcon = "wi wi-dust";
						}
						//날씨 아이콘
						document.getElementById("weather-icon").className = weatherIcon;

						document.getElementsByClassName("weather-location")[0].innerText = place;
						document.getElementsByClassName("weather-temp")[0].innerText = temp;
						document.getElementsByClassName("weather-temp-max")[0].innerText = tempMax;
						document.getElementsByClassName("weather-temp-min")[0].innerText = tempMin;
						document.getElementsByClassName("weather-humidity")[0].innerText = humidity;
						document.getElementsByClassName("weather-stat")[0].innerText = stat;
					});

	$(function() {
		$("#nav-home").click(function() {
			$("#home").css("display", "flex");
			$("#nav-home").css("color", "#08AEEA");

			$("#weather").css("display", "none");
			$("#nav-weather").css("color", "#fff");

			$("#bus").css("display", "none");
			$("#nav-bus").css("color", "#fff");
		});

		$("#nav-weather").click(function() {
			$("#home").css("display", "none");
			$("#nav-home").css("color", "#fff");

			$("#weather").css("display", "flex");
			$("#nav-weather").css("color", "#08AEEA");

			$("#bus").css("display", "none");
			$("#nav-bus").css("color", "#fff");
		});

		$("#nav-bus").click(function() {
			$("#home").css("display", "none");
			$("#nav-home").css("color", "#fff");

			$("#weather").css("display", "none");
			$("#nav-weather").css("color", "#fff");

			$("#bus").css("display", "flex");
			$("#nav-bus").css("color", "#08AEEA");
		});
	});
</script>



<script type="text/javascript">
	
</script>
</head>

<body>
	<header></header>
	<main>
		<div class="main-inner">
			<div class="contentbox">
				<div class="contentbox-inner">
					<!--메인 화면-->
					<div id="home">
						<div class="home">
							<p class="home-title">HOME</p>
							<a href="https://github.com/thyoondev" target="_blank"><p
									class="home-devinfo">개발자 GITHUB</p></a>
						</div>
					</div>

					<!--날씨 탭-->
					<div id="weather">
						<div class="weather">
							<p class="weather-location"></p>
							<br />
							<p class="weather-stat"></p>
							<i id="weather-icon" class="wi"></i>
							<p class="weather-temp"></p>
							<span class="weather-temp-max"></span> <span
								class="weather-temp-min"></span> <br /> <br />
							<p class="weather-humidity"></p>
							<p class="weather-rain"></p>
						</div>
					</div>

					<!--버스 정보-->
					<div id="bus">
						<div class="bus">
						<% for(int temp = 0; temp < nList.getLength(); temp++){		
							Node nNode = nList.item(temp);
							if(nNode.getNodeType() == Node.ELEMENT_NODE){
										
								Element eElement = (Element) nNode;%>
								<div class="bus-table">
									<p class="bus-table-num"><%=dao.getTagValue("ROUTE_NO", eElement) %></p>
									<p class="bus-table-lastBusStop">종점 : <%=dao.getTagValue("DESTINATION", eElement) %></p>
									<p class="bus-table-remainTime">도착예정시간(분) : <%=dao.getTagValue("EXTIME_MIN", eElement)%>분</p>
									<p class="bus-table-nowLocation">잔여 정류장 수  : <%=dao.getTagValue("STATUS_POS", eElement) %>개</p>
								</div>
							<%}	// for end
						}	// if end%>
						</div>
					</div>
				</div>
			</div>
		</div>
			<nav>
		<div class="nav-inner">
			<div class="nav-inner-icon" id="nav-home">
				<i class="fi-rr-home"></i>
				<p class="nav-inner-txt">HOME</p>
			</div>
			<div class="nav-inner-icon" id="nav-weather">
				<i class="fi-rr-umbrella"></i>
				<p class="nav-inner-txt">Weather</p>
			</div>
			<div class="nav-inner-icon" id="nav-bus">
				<i class="fi-rr-school-bus"></i>
				<p class="nav-inner-txt">BUS</p>
			</div>
			<!--
	            <div class="nav-inner-icon">
                    <i class="fi-rr-alarm-clock"></i>
                    <p class="nav-inner-txt">Alarm</p>
	            </div>
-->
		</div>
	</nav>
	</main>


	<footer></footer>
	<script type="text/javascript" src=""></script>
</body>
</html>
