import { alertModal } from "../components/alert_modal";

function editProductImage() {
  document.querySelectorAll(".product-image").forEach((product) => {
    product.addEventListener("click", (event) => {
      //   event.preventDefault();
      const productId = product.dataset.productId;
      const form = createFormImage().outerHTML;
      alertModal("Add image", form);
      const imageForm = document.getElementById("product-image-form");
      imageForm.addEventListener("submit", (event) => {
        handleSubmit(productId, event);
      });
    });
  });
}

function createFormImage() {
  const productImageForm = document.createElement("form");
  productImageForm.id = "product-image-form";

  const productEditImage = document.createElement("input");
  productEditImage.setAttribute("type", "file");
  productEditImage.setAttribute("name", "product[image]");
  productEditImage.className = "form-control-file";

  const productEditSubmit = document.createElement("input");
  productEditSubmit.setAttribute("type", "submit");
  productEditSubmit.setAttribute("value", "Update Image");
  productEditSubmit.className = "btn btn-primary btn-block mt-2";

  productImageForm.appendChild(productEditImage);
  productImageForm.appendChild(productEditSubmit);

  return productImageForm;
}

function handleSubmit(productId, event) {
//   event.preventDefault();
  const formData = new FormData();
  const imageInput = event.target.firstElementChild;
  formData.append("product[image]", imageInput.files[0]);

  fetch(`/api/v1/products/${productId}`, {
    method: "PATCH",
    // headers: { "Content-Type": "multipart/form-data" },
    body: formData,
  })
    .then((response) => response.json())
    .then((responseData) => console.log(responseData))
    .catch((error) => console.log(error));
}

export { editProductImage };
