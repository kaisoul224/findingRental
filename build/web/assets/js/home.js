var homeSearch = document.getElementById("search_home");
var homeSearchBtn = document.getElementById("search_home-btn");

// Event listener for click on homeSearchBtn
homeSearchBtn.addEventListener("click", function() {
  var searchValue = homeSearch.value.toLowerCase();

  // Perform further actions with the search value, such as sending it to a server-side script

  // Example: Redirect to a URL with the search value as a parameter
  window.location.href = "find?query=" + encodeURIComponent(searchValue);
});
