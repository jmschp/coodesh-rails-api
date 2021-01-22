// import { Modal } from "bootstrap";

function alertModal(titleText, bodyHtml) {
  // const productsUploadModal = document.getElementById("product-modal");
  const productsUploadModalTitle = document.getElementById("product-modal-title");
  const productsUploadModalBody = document.getElementById("product-modal-body");
  productsUploadModalTitle.textContent = "";
  productsUploadModalBody.innerHTML = "";
  // const productsModal = new Modal(productsUploadModal);
  productsUploadModalTitle.textContent = titleText;
  productsUploadModalBody.innerHTML = bodyHtml;
  // productsModal.show();
  $("#product-modal").modal("show");
}

export { alertModal };
