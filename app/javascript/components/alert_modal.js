import { Modal } from "bootstrap";

function alertModal(whereToInsertHtml, htmlToInsert) {
  const productsUploadModal = document.getElementById("product-upload-modal");
  const productsUploadModalBody = document.getElementById("product-upload-modal-body");
  productsUploadModalBody.innerHTML = "";
  const productsModal = new Modal(productsUploadModal);
  productsUploadModalBody.insertAdjacentHTML(whereToInsertHtml, htmlToInsert);
  productsModal.show();
}

export { alertModal };
