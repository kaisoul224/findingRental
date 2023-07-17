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
    window.location.href = "updatePost?id=" + postId;
}

function deletePost(postId) {
    // Perform the necessary logic to update the post
    // For example, you can redirect to an update page with the post ID
    window.location.href = "deletePost?id=" + postId;
}

function PostDetail(postId) {
    // Perform the necessary logic to update the post
    // For example, you can redirect to an update page with the post ID
    window.location.href = "postDetail?id=" + postId;
}




