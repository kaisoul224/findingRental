
// Khởi tạo biến map
var map;

// Hàm khởi tạo và hiển thị bản đồ
function initMap() {
    // Tạo một đối tượng LatLng để định vị vị trí ban đầu
    var myLatLng = {lat: 10.123456, lng: 20.123456};

    // Tạo một đối tượng Map và gắn vào phần tử div có id="map"
    map = new google.maps.Map(document.getElementById('map'), {
        center: myLatLng,
        zoom: 15
    });

    // Tạo một thanh tìm kiếm vị trí trên bản đồ
    var searchBox = new google.maps.places.SearchBox(document.getElementById('search-location'));

    // Lắng nghe sự kiện khi người dùng tìm kiếm vị trí
    searchBox.addListener('places_changed', function () {
        var places = searchBox.getPlaces();

        if (places.length === 0) {
            return;
        }

        // Xóa các kết quả tìm kiếm trước đó
        markers.forEach(function (marker) {
            marker.setMap(null);
        });
        markers = [];

        // Đặt lại trung tâm bản đồ và hiển thị kết quả tìm kiếm mới
        var bounds = new google.maps.LatLngBounds();
        places.forEach(function (place) {
            if (!place.geometry) {
                console.log("Returned place contains no geometry");
                return;
            }

            // Tạo một đánh dấu trên bản đồ cho vị trí tìm kiếm
            var marker = new google.maps.Marker({
                map: map,
                title: place.name,
                position: place.geometry.location
            });

            // Thêm đánh dấu vào danh sách đánh dấu
            markers.push(marker);

            // Mở rộng ranh giới của bản đồ để hiển thị tất cả các đánh dấu
            if (place.geometry.viewport) {
                bounds.union(place.geometry.viewport);
            } else {
                bounds.extend(place.geometry.location);
            }
        });

        // Đặt lại ranh giới của bản đồ để hiển thị tất cả các đánh dấu
        map.fitBounds(bounds);
    });
}


