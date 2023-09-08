function searchPosts() {
    var input = removeDiacritics(document.getElementById("postSearchQuery").value.toLowerCase());
    var tableBody = document.getElementById("postsTableBody");
    var rows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var title = removeDiacritics(rows[i].getElementsByTagName("td")[1].innerText.toLowerCase());
        var address = removeDiacritics(rows[i].getElementsByTagName("td")[3].innerText.toLowerCase());

        if (title.includes(input) || address.includes(input)) {
            rows[i].style.display = "";
        } else {
            rows[i].style.display = "none";
        }
    }
}

function searchUsers() {
    var input = removeDiacritics(document.getElementById("userSearchQuery").value.toLowerCase());
    var tableBody = document.getElementById("usersTableBody");
    var rows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var username = removeDiacritics(rows[i].getElementsByTagName("td")[1].innerText.toLowerCase());
        var fullName = removeDiacritics(rows[i].getElementsByTagName("td")[4].innerText.toLowerCase());

        if (username.includes(input) || fullName.includes(input)) {
            rows[i].style.display = "";
        } else {
            rows[i].style.display = "none";
        }
    }
}

function removeDiacritics(text) {
    return text.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
}

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

function updateUser(userId) {
    // Perform the necessary logic to update the post
    // For example, you can redirect to an update page with the post ID
    window.location.href = "changeInfo?id=" + btoa(userId);
}

function deleteUser(userId) {
    // Perform the necessary logic to update the post
    // For example, you can redirect to an update page with the post ID
    window.location.href = "deleteUser?id=" + btoa(userId);
}

function addUser() {
    // Perform the necessary logic to update the post
    // For example, you can redirect to an update page with the post ID
    window.location.href = "./addUser";
}

function addPost() {
    // Perform the necessary logic to update the post
    // For example, you can redirect to an update page with the post ID
    window.location.href = "./post";
}

