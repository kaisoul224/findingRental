var homeSearchValue = document.getElementById("search_home");
var homeSearchBtn1 = document.getElementById("search_home-btn-1");

// Event listener for click on homeSearchBtn
homeSearchBtn1.addEventListener("click", function () {
    var searchValue = homeSearchValue.value.toLowerCase();
    if (searchValue === "") {
        searchValue = 'none';
    }
    if (searchValue !== "none") {
        window.location.href = "find?title=" + encodeURIComponent(searchValue);
    }

});


var homeSearchBtn2 = document.getElementById("search_home-btn-2");
var citySearchValue = document.getElementById("search_city");
var priceSearchValue = document.getElementById("search_price");

homeSearchBtn2.addEventListener("click", function () {
    var cityValue = citySearchValue.value.toLowerCase();
    var priceValue = priceSearchValue.value.toLowerCase();
    if (cityValue === 'select city') {
        cityValue = 'none';
    }
    if (priceValue === 'select rental price') {
        priceValue = 'none';
    }
    var data = cityValue + ":" + priceValue;
    console.log(data);
    if (cityValue !== "none" || priceValue !== "none") {
        window.location.href = "find?city=" + encodeURIComponent(cityValue) + ":" + encodeURIComponent(priceValue);
    }

});

function updatePost(postId) {
    // Perform the necessary logic to update the post
    // For example, you can redirect to an update page with the post ID
    window.location.href = "updatePost?id=" + btoa(postId);
}

function deletePost(postId) {
    // Perform the necessary logic to update the post
    // For example, you can redirect to an update page with the post ID
    window.location.href = "deletePost?id=" + btoa(postId);
}


// Function to handle click outside the nav
function handleClickOutsideNav(event) {
    var nav = document.querySelector('.nav');
    var menuTrigger = document.querySelector('.menu-trigger');

    // Check if the clicked element is outside the nav and menu trigger
    if (!nav.contains(event.target) && !menuTrigger.contains(event.target)) {
        nav.style.display = 'none';
    }
}

// Add event listener for click outside the nav
document.addEventListener('click', handleClickOutsideNav);

function validateForm() {
    var searchInput = document.getElementById("search_home").value;
    if (searchInput.trim() === "") {
        alert("Please enter a search term.");
        return false; // Prevent form submission
    }
    return true; // Allow form submission
}
