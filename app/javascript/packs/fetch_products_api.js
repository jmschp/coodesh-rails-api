import { fetchWithAuth } from "../utils/fetch_with_auth";

function fetchProductsApi(url, options) {
  fetchWithAuth(url, options)
    .then((response) => response.json())
    .then((data) => {
      const productTableBody = document.querySelector(".products-table-body");
      data.forEach((product) => {
        insertProductRows(productTableBody, product);
      });
    });
}

function insertProductRows(productTableBody, product) {
  const price = parseFloat(product.price).toLocaleString("pt-BR", {
    currency: "BRL",
    style: "currency",
  });
  const dateCreated = new Date(product.created_at).toLocaleString("pt-BR", {
    dateStyle: "short",
  });
  productTableBody.insertAdjacentHTML(
    "beforeend",
    `<th scope="row">${product.title}</th>
    <td>${product.category}</td>
    <td>${product.rating}</td>
    <td>${price}</td>
    <td>${dateCreated}</td>
    <td>Edit \ Delete</td>`
  );
}

export { fetchProductsApi };
