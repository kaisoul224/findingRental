const wrapper = document.querySelector(".wrapper"),
    selectBtn = wrapper.querySelector(".select-btn"),
    searchInp = wrapper.querySelector("input"),
    options = wrapper.querySelector(".options");

const cities = ["Hà Nội", "Hải Phòng", "Đà Nẵng", "Hồ Chí Minh", "Cần Thơ", "An Giang", "Bình Dương", "Bà Rịa - Vũng Tàu",
    "Bắc Giang", "Bắc Kạn", "Bạc Liêu", "Bắc Ninh", "Bến Tre", "Bình Phước", "Bình Thuận", "Bình Định", "Cà Mau", "Cao Bằng",
    "Gia Lai", "Hà Giang", "Hà Nam", "Hà Tĩnh", "Huế", "Hải Dương", "Hậu Giang", "Hòa Bình", "Hưng Yên", "Khánh Hòa", "Kiên Giang",
    "Kon Tum", "Lai Châu", "Lâm Đồng", "Lạng Sơn", "Lào Cai", "Long An", "Nam Định", "Nghệ An", "Ninh Bình", "Ninh Thuận", "Phú Thọ",
    "Phú Yên", "Quảng Bình", "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng", "Sơn La", "Tây Ninh", "Thái Bình",
    "Thái Nguyên", "Thanh Hóa", "Tiền Giang", "Trà Vinh", "Tuyên Quang", "Vĩnh Long", "Vĩnh Phúc", "Yên Bái", "Đắk Lắk", "Đắk Nông", "Điện Biên", "Đồng Nai", "Đồng Tháp"];

function addCity(selectedCity) {
    options.innerHTML = "";
    cities.forEach(city => {
        let isSelected = city === selectedCity ? "selected" : "";
        let li = `<li onclick="updateName(this)" class="${isSelected}">${city}</li>`;
        options.insertAdjacentHTML("beforeend", li);
    });
}
addCity();


var searchCityVal = document.getElementById("search_city");

function updateName(selectedLi) {
    searchInp.value = "";
    addCity(selectedLi.innerText);
    wrapper.classList.remove("active");
    searchCityVal.value = selectedLi.textContent;
}



searchInp.addEventListener("keyup", () => {
    let arr = [];
    let searchWord = searchInp.value.toLowerCase();
    arr = cities.filter(data => {
        return data.toLowerCase().startsWith(searchWord);
    }).map(data => {
        let isSelected = data == searchCityVal.value ? "selected" : "";
        return `<li onclick="updateName(this)" class="${isSelected}">${data}</li>`;
    }).join("");
    options.innerHTML = arr ? arr : `<p style="margin-top: 10px;">City not found!</p>`;
});




// Add an event listener to the document for a click event
document.addEventListener("click", function(event) {
    const isClickInside = wrapper.contains(event.target); // Check if the click is inside the wrapper
  
    if (!isClickInside) {
      // If the click is outside the wrapper, hide the dropdown
      wrapper.classList.remove("active");
    }
  });

selectBtn.addEventListener("click", () => wrapper.classList.toggle("active"));