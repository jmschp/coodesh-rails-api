import { Modal } from "bootstrap";
import {fetchProductsApi} from "./fetch_products_api"

function postProductsForm() {
  const uploadFileForm = document.getElementById("upload-file-form");
  const fileInputField = document.getElementById("file");
  const productsUploadModal = document.getElementById("product-upload-modal");
  const productsUploadModalBody = document.getElementById("product-upload-modal-body");
  const productsModal = new Modal(productsUploadModal);

  uploadFileForm.addEventListener("submit", (event) => {
    event.preventDefault();
    fetch("/api/v1/products", {
      method: "POST",
      body: fileInputField.files[0],
    })
      .then((response) => response.json())
      .then((data) => {
        productsUploadModalBody.insertAdjacentHTML(
          "beforeend",
          `<p>Total products uploaded: ${data.products_uploaded_count}</p>
          <p>Total products saved: ${data.products_saved_count}</p>
          <p>Total products unsaved: ${data.products_unsaved_count}</p>`
        );
        productsModal.show();
        fetchProductsApi("/api/v1/products");
      });
    productsUploadModalBody.innerHTML = "";
  });
}

export { postProductsForm };
