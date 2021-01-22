import { alertModal } from "../components/alert_modal";

function editProduct() {
  document.querySelectorAll(".product-edit").forEach((product) => {
    // console.log(product)
    product.addEventListener("click", (event) => {
      event.preventDefault();
      const productId = product.dataset.productId;
      console.log(productId);
      fetch(`api/v1/products/${productId}`)
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          // const form = document.createElement("form");
          // console.log(createForm(data));
          const form = createForm(data).outerHTML;
          console.log(form);
          alertModal("beforeend", form);
        });
    });
  });
}

function createForm(formValues) {
  const productEditForm = document.createElement("form");
  const productEditTitle = document.createElement("input");
  productEditTitle.type = "text";
  productEditTitle.className = "form-control is-valid string required";
  productEditTitle.setAttribute("value", formValues.title);
  const productEditCategory = document.createElement("select");
  const categories = [" ", "dairy", "fruit", "vegetable", "bakery", "vegan", "meat"];
  categories.forEach((category) => {
    const productEditCategoryOption = document.createElement("option");
    productEditCategoryOption.value = category;
    productEditCategoryOption.innerText = category;

    if (formValues.category === productEditCategoryOption.value) productEditCategoryOption.selected = "selected";
    productEditCategory.appendChild(productEditCategoryOption);
  });

  productEditForm.appendChild(productEditTitle);
  productEditForm.appendChild(productEditCategory);

  return productEditForm;
}

export { editProduct };
