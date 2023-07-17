function redirectToPrice(price) {
  // Get the current URL.
  window.location.href = "./find?price=" + encodeURIComponent(price);


}

// Attach the click event handler to the radio buttons.
$("input[name='price']").click(function() {
  // Get the value of the radio button that was clicked.
  var price = $(this).val();

  // Redirect to the URL with the price as a query parameter.
  redirectToPrice(price);
});

const cities = ["Hà Nội", "Hải Phòng", "Đà Nẵng", "TP Hồ Chí Minh", "Cần Thơ", "An Giang", "Bình Dương", "Bà Rịa - Vũng Tàu",
    "Bắc Giang", "Bắc Kạn", "Bạc Liêu", "Bắc Ninh", "Bến Tre", "Bình Phước", "Bình Thuận", "Bình Định", "Cà Mau", "Cao Bằng",
    "Gia Lai", "Hà Giang", "Hà Nam", "Hà Tĩnh", "Huế", "Hải Dương", "Hậu Giang", "Hòa Bình", "Hưng Yên", "Khánh Hòa", "Kiên Giang",
    "Kon Tum", "Lai Châu", "Lâm Đồng", "Lạng Sơn", "Lào Cai", "Long An", "Nam Định", "Nghệ An", "Ninh Bình", "Ninh Thuận", "Phú Thọ",
    "Phú Yên", "Quảng Bình", "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng", "Sơn La", "Tây Ninh", "Thái Bình",
    "Thái Nguyên", "Thanh Hóa", "Tiền Giang", "Trà Vinh", "Tuyên Quang", "Vĩnh Long", "Vĩnh Phúc", "Yên Bái", "Đắk Lắk", "Đắk Nông", "Điện Biên", "Đồng Nai", "Đồng Tháp"];


const searchCitySelect = document.getElementById("search_city");

cities.forEach((city) => {
  const option = document.createElement("option");
  option.value = city;
  option.textContent = city;
  searchCitySelect.appendChild(option);
});

searchCitySelect.addEventListener("change", function() {
  const selectedCity = this.value;
  if (selectedCity) {
    const normalizedCity = selectedCity.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
    const encodedCity = encodeURIComponent(normalizedCity);
        console.log(encodedCity);
    window.location.href = `find?city=${encodedCity}`;
  }
});

function displayDataOnCurrentPage() {
  const startIndex = (currentPage - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;

  const currentData = databaseData.slice(startIndex, endIndex);

  const mainContent = document.querySelector('.main-content');
  mainContent.innerHTML = ''; // Clear existing content

  currentData.forEach((post) => {
    const item = document.createElement('div');
    item.className = 'item-find';

    const row = document.createElement('div');
    row.className = 'row';

    const colMd5 = document.createElement('div');
    colMd5.className = 'col-md-5 pic';

    const imgLink = document.createElement('a');
    imgLink.href = '#';

    const img = document.createElement('img');
    img.src = post.url;
    img.alt = 'Image';
    img.className = 'img-item';

    imgLink.appendChild(img);
    colMd5.appendChild(imgLink);

    // ... Create and append other elements for title, address, price, etc.

    row.appendChild(colMd5);
    row.appendChild(colMd7);

    item.appendChild(row);
    mainContent.appendChild(item);
  });
}


function updatePost(postId) {
    // Perform the necessary logic to update the post
    // For example, you can redirect to an update page with the post ID
    window.location.href = "updatePost?id=" + postId;
}

function deletePost(postId) {
    // Perform the necessary logic to update the post
    // For example, you can redirect to an update page with the post ID
    window.location.href = "deletePost?id=" + postId;
}