const selectButton = document.querySelector(".select-button");
const items = document.querySelectorAll(".item");
const searchPrice = document.getElementById("search_price");

selectButton.addEventListener("click", () => {
  selectButton.classList.toggle("open");
});

items.forEach((item) => {
  item.addEventListener("click", function (event) {
    const selectedValue = this.querySelector("input").value;
    const selectedLabel = this.querySelector("label").innerText;
    const priceRange = selectedValue.split("-");
    searchPrice.value = priceRange[0] + "-" + priceRange[1];
    selectButton.classList.remove("open");
    selectButton.querySelector("input").value = selectedLabel;

    // Use the searchPrice.value for further processing if needed
    // ...
  });
});

document.addEventListener("click", function (event) {
  const atButtonClick = selectButton.contains(event.target);
  if (!atButtonClick) {
    selectButton.classList.remove("open");
  }
});

