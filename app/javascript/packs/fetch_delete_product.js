import { alertModal } from "../components/alert_modal";

function deleteApi() {
  document.querySelectorAll(".product-del").forEach((product) => {
    const productId = product.dataset.productId;
    product.addEventListener("click", (event) => {
      event.preventDefault();
      fetch(`/api/v1/products/${productId}`, { method: "DELETE" })
        .then((response) => response.json())
        .then((data) => {
          alertModal("Products deleted", `<p>${data.message}</p>`);
          setTimeout(() => {
            location.reload();
          }, 1500);
        });
    });
  });
}

export { deleteApi };
