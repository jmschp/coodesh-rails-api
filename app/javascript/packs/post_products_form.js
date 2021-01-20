import { fetchWithAuth } from "../utils/fetch_with_auth";

// /api/v1/products

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
      .then((data) => console.log(data))
      .catch((error) => console.error(error));
  });
}




export { postProductsForm };
