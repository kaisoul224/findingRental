/*

*/
let names = [
    "Hà Nội", "Hải Phòng", "Đà Nẵng", "Hồ Chí Minh", "Cần Thơ", "An Giang", "Bình Dương", "Bà Rịa - Vũng Tàu",
    "Bắc Giang", "Bắc Kạn", "Bạc Liêu", "Bắc Ninh", "Bến Tre", "Bình Phước", "Bình Thuận", "Bình Định", "Cà Mau", "Cao Bằng",
    "Gia Lai", "Hà Giang", "Hà Nam", "Hà Tĩnh", "Huế", "Hải Dương", "Hậu Giang", "Hòa Bình", "Hưng Yên", "Khánh Hòa", "Kiên Giang",
    "Kon Tum", "Lai Châu", "Lâm Đồng", "Lạng Sơn", "Lào Cai", "Long An", "Nam Định", "Nghệ An", "Ninh Bình", "Ninh Thuận", "Phú Thọ",
    "Phú Yên", "Quảng Bình", "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng", "Sơn La", "Tây Ninh", "Thái Bình",
    "Thái Nguyên", "Thanh Hóa", "Tiền Giang", "Trà Vinh", "Tuyên Quang", "Vĩnh Long", "Vĩnh Phúc", "Yên Bái", "Đắk Lắk", "Đắk Nông", "Điện Biên", "Đồng Nai", "Đồng Tháp"
  ];
  //Sort names in ascending order
  let sortedNames = names.sort();
  
  //reference
  let input = document.getElementById("input");
  
  //Execute function on keyup
  input.addEventListener("keyup", (e) => {
    //loop through above array
    //Initially remove all elements ( so if user erases a letter or adds new letter then clean previous outputs)
    removeElements();
    for (let i of sortedNames) {
      //convert input to lowercase and compare with each string
  
      if (
        i.toLowerCase().startsWith(input.value.toLowerCase()) &&
        input.value != ""
      ) {
        //create li element
        let listItem = document.createElement("li");
        //One common class name
        listItem.classList.add("list-items-rental");
        listItem.style.cursor = "pointer";
        listItem.setAttribute("onclick", "displayNames('" + i + "')");
        //Display matched part in bold
        let word = "<b>" + i.substr(0, input.value.length) + "</b>";
        word += i.substr(input.value.length);
        //display the value in array
        listItem.innerHTML = word;
        document.querySelector(".list").appendChild(listItem);
      }
    }
  });
  function displayNames(value) {
    input.value = value;
    removeElements();
  }
  function removeElements() {
    //clear all the item
    let items = document.querySelectorAll(".list-items-rental");
    items.forEach((item) => {
      item.remove();
    });
  }
  