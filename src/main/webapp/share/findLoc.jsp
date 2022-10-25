<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="share.*,java.text.SimpleDateFormat"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/main.css" rel="stylesheet" type="text/css"
	media="screen and (max-width:2470px)">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<title>지도에서 주소찾기</title>
<style>
.map_wrap {
	position: relative;
	width: 100%;
	height: 350px;
}

.title {
	font-weight: bold;
	display: block;
}

.hAddr {
	position: absolute;
	left: 10px;
	top: 10px;
	border-radius: 2px;
	background: #fff;
	background: rgba(255, 255, 255, 0.8);
	z-index: 100;
	padding: 5px;
}

#centerAddr {
	display: block;
	margin-top: 2px;
	font-weight: normal;
}

.bAddr {
	padding: 5px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
.searchbar{
position: absolute;
	left: 900px;
	top: 10px;
	border-radius: 2px;
	background: #fff;
	background: rgba(255, 255, 255, 0.8);
	z-index: 100;
	padding: 5px;
}
</style>
</head>
<script type="text/javascript">
	
</script>
<body style="display: flex; justify-content: center;">
	<div>
		<div class="map_wrap">
			<div id="map" style="width: 100%; height: 700px;">
			<div class="searchbar">
					<input type="text" placeholder=" 도로명주소 입력해주세요" width="50px"
						id="searchtext" /> <input type="button" value="검색" id="searchBtn" />
				</div>
				<div class="hAddr">
					<span class="title">현재위치 주소정보</span> <span id="centerAddr"></span>
				</div>
			</div>
		</div>
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b73875579de27ab7f4a19edab09ba444&libraries=services"></script>
		<script type="text/javascript">
		var mapContainer = document.getElementById("map"), // 지도를 표시할 div
		mapOption = {
			center: new kakao.maps.LatLng(37.50576119066, 127.055723535), // 지도의 중심좌표
			level: 12, // 지도의 확대 레벨
			// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
	
		var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
			infowindow = new kakao.maps.InfoWindow({
				zindex: 1,
			}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
		// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({
			// 지도 중심좌표에 마커를 생성합니다
			position: map.getCenter(),
		});
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		
		$("#searchBtn").click(function () {
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch($("#searchtext").val(), function (result, status) {
				// 정상적으로 검색이 완료됐으면
				if (status === kakao.maps.services.Status.OK) {
					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

					// 추출한 좌표를 통해 도로명 주소 추출
					let lat = result[0].y;
					let lng = result[0].x;
					getAddr(lat, lng);
					function getAddr(lat, lng) {
						let geocoder = new kakao.maps.services.Geocoder();

						let coord = new kakao.maps.LatLng(lat, lng);
						let callback = function (result, status) {
							if (status === kakao.maps.services.Status.OK) {
								// 추출한 도로명 주소를 해당 input의 value값으로 적용
								$("#searchtext").val(
									result[0].road_address.address_name,
								);
							}
						};
						geocoder.coord2Address(
							coord.getLng(),
							coord.getLat(),
							callback,
						);
					}

					var imageSrc2 =
							"https://lh3.google.com/u/0/d/1K6YKCzYB11K2K2QFBdxioIgbbNFxZyD7=w2880-h1382-iv1", // 마커이미지의 주소입니다
						imageSize2 = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
						imageOption2 = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

					// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
					var markerImage2 = new kakao.maps.MarkerImage(
						imageSrc2,
						imageSize2,
						imageOption2,
					);

					// 결과값으로 받은 위치를 마커로 표시합니다
					var marker = new kakao.maps.Marker({
						map: map,
						position: coords,
						image: markerImage2,
					});

					// 인포윈도우로 장소에 대한 설명을 표시합니다
					var infowindow = new kakao.maps.InfoWindow({
						content:
							'<div style="width:150px;text-align:center;padding:6px 0;">검색한 장소</div>',
					});
					infowindow.open(map, marker);

					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.setCenter(coords);
				}
			});
		});
		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, "click", function Mark(mouseEvent) {
			searchDetailAddrFromCoords(mouseEvent.latLng, function (result, status) {
				if (status === kakao.maps.services.Status.OK) {
					var detailAddr = !!result[0].road_address
						? "<div>도로명주소 : " +
						  result[0].road_address.address_name +
						  "</div>"
						: "";
					detailAddr +=
						"<div>지번 주소 : " + result[0].address.address_name + "</div>";
					var detailAddrname = !!result[0].road_address
						? result[0].road_address.address_name
						: result[0].address.address_name;
	
					var content =
						'<div class="bAddr">' +
						'<span class="title">법정동 주소정보</span>' +
						detailAddr +
						"</div>";
	
					/* console.log(detailAddrname) */
					// 마커를 클릭한 위치에 표시합니다
					marker.setPosition(mouseEvent.latLng);
					marker.setMap(map);
	
					// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
					infowindow.setContent(content);
					infowindow.open(map, marker);
					// 클릭한 위도, 경도 정보를 가져옵니다
					var latlng = mouseEvent.latLng;
	
					// 마커 위치를 클릭한 위치로 옮깁니다
					marker.setPosition(latlng);
	
					var message =
						"클릭한 위치의 위도는 " +
						latlng.getLat() +
						" 이고, " +
						"경도는 " +
						latlng.getLng() +
						" 입니다";
					message += " \n\n 도로명주소는 " + detailAddrname + " 입니다";
					opener.document.writeform.lat.value = latlng.getLat();
					opener.document.writeform.lng.value = latlng.getLng();
					opener.document.writeform.address.value = detailAddrname;
					var resultDiv = document.getElementById("clickLatlng");
					resultDiv.innerHTML = message;
				}
			});
		});
	
		// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, "idle", function () {
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});
	
		function searchAddrFromCoords(coords, callback) {
			// 좌표로 행정동 주소 정보를 요청합니다
			geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
		}
	
		function searchDetailAddrFromCoords(coords, callback) {
			// 좌표로 법정동 상세 주소 정보를 요청합니다
			geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}
	
		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var infoDiv = document.getElementById("centerAddr");
	
				for (var i = 0; i < result.length; i++) {
					// 행정동의 region_type 값은 'H' 이므로
					if (result[i].region_type === "H") {
						infoDiv.innerHTML = result[i].address_name;
						break;
					}
				}
			}
		}
		function test() {
			alert("저장되었습니다.");
			self.close();
		}		
		</script>
		<div style="z-index: 999; margin-top: 350px;">
			<div id="clickLatlng"></div>
			<input class="btn btn-outline-success" type="button" value="저장" onclick="test()">
		</div>
	</div>
</body>
</html>