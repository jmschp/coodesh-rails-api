import { fetchProductsApi } from "./fetch_products_api";
import { alertModal } from "../components/alert_modal";

function postProductsForm() {
  const uploadFileForm = document.getElementById("upload-file-form");
  const fileInputField = document.getElementById("file");

  uploadFileForm.addEventListener("submit", (event) => {
    event.preventDefault();
    fetch("/api/v1/products", {
      method: "POST",
      body: fileInputField.files[0],
    })
      .then((response) => response.json())
      .then((data) => {
        alertModal(
          "beforeend",
          `<p>Total products uploaded: ${data.products_uploaded_count}</p>
          <p>Total products saved: ${data.products_saved_count}</p>
          <p>Total products unsaved: ${data.products_unsaved_count}</p>`
        );
        fetchProductsApi("/api/v1/products");
        uploadFileForm.reset();
      });
  });
}

export { postProductsForm };
