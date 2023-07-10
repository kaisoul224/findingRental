const selectButton = document.querySelector(".select-button");
const items = document.querySelectorAll(".item");

selectButton.addEventListener("click", () => {
  selectButton.classList.toggle("open");
});

items.forEach(item => {
  item.addEventListener("click", function(event) {
    const selectedValue = this.querySelector("input").value;
    selectButton.firstElementChild.textContent = selectedValue;
    selectButton.classList.remove("open");
  });
});

document.addEventListener("click", function(event) {
  const atButtonClick = selectButton.contains(event.target);
  if (!atButtonClick) {
    selectButton.classList.remove("open");
  }
});
