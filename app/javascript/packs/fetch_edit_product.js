import { alertModal } from "../components/alert_modal";

function editProduct() {
  document.querySelectorAll(".product-edit").forEach((product) => {
    product.addEventListener("click", (event) => {
      event.preventDefault();
      const productId = product.dataset.productId;
      fetch(`api/v1/products/${productId}`)
        .then((response) => response.json())
        .then((data) => {
          const form = createForm(data).outerHTML;
          alertModal("Edit product", form);
          const updatedForm = document.getElementById("product-edit-form");
          updatedForm.addEventListener("submit", (event) => {
            handleSubmit(productId, event);
          });
        });
    });
  });
}

function createForm(formValues) {
  const productEditForm = document.createElement("form");
  productEditForm.id = "product-edit-form";
  const productEditTitle = document.createElement("input");
  productEditTitle.setAttribute("type", "text");
  productEditTitle.setAttribute("name", "title");
  productEditTitle.setAttribute("value", formValues.title);
  productEditTitle.className = "form-control";

  const productEditCategory = document.createElement("select");
  productEditCategory.setAttribute("name", "type");
  productEditCategory.className = "form-control my-3";
  const categories = [" ", "dairy", "fruit", "vegetable", "bakery", "vegan", "meat"];
  categories.forEach((category) => {
    const productEditCategoryOption = document.createElement("option");
    productEditCategoryOption.setAttribute("value", category);
    productEditCategoryOption.innerText = category;
    if (formValues.category === productEditCategoryOption.value)
      productEditCategoryOption.setAttribute("selected", "selected");
    productEditCategory.appendChild(productEditCategoryOption);
  });
  // const productEditPriceLabel = document.createElement("label");
  // productEditPriceLabel.setAttribute;
  const productEditPrice = document.createElement("input");
  productEditPrice.setAttribute("type", "number");
  productEditPrice.setAttribute("name", "price");
  productEditPrice.setAttribute("value", formValues.price);
  productEditPrice.setAttribute("step", "any");
  productEditPrice.className = "form-control mb-2";

  const productEditImage = document.createElement("input");
  productEditImage.setAttribute("type", "file");
  productEditImage.setAttribute("name", "image");
  productEditImage.className = "form-control-file";

  const productEditSubmit = document.createElement("input");
  productEditSubmit.setAttribute("type", "submit");
  productEditSubmit.setAttribute("value", "Update Product");
  productEditSubmit.className = "btn btn-primary btn-block mt-2";

  productEditForm.appendChild(productEditTitle);
  productEditForm.appendChild(productEditCategory);
  productEditForm.appendChild(productEditPrice);
  productEditForm.appendChild(productEditImage);
  productEditForm.appendChild(productEditSubmit);

  return productEditForm;
}

function handleSubmit(productId, event) {
  // event.preventDefault();
  const data = new FormData(event.target);
  const values = Object.fromEntries(data.entries());
  const body = JSON.stringify(values);
  fetch(`/api/v1/products/${productId}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: body,
  })
    .then((response) => response.json())
    .then((data) => console.log(data))
    .catch((error) => console.log(error));
}

export { editProduct };
