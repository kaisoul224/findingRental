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
function showFullImage(imageElement) {
    var imageUrl = imageElement.getAttribute('src');

    // Create a modal/lightbox element
    var modal = document.createElement('div');
    modal.classList.add('modal');

    // Create an image element inside the modal
    var modalImage = document.createElement('img');
    modalImage.classList.add('modal-image');
    modalImage.setAttribute('src', imageUrl);

    // Append the modal image to the modal
    modal.appendChild(modalImage);

    // Append the modal to the document body
    document.body.appendChild(modal);

    // Add a click event listener to the modal to close it when clicked
    modal.addEventListener('click', function () {
        modal.remove();
    });
}
