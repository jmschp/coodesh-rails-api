function fetchProductsApi(url, callback) {
  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      const productTableBody = document.querySelector(".products-table-body");
      if (productTableBody) {
        data.forEach((product) => {
          insertProductRows(productTableBody, product);
        });
        callback();
      }
    });
}

function insertProductRows(productTableBody, product) {
  const price = parseFloat(product.price).toLocaleString("pt-BR", { currency: "BRL", style: "currency" });
  const dateCreated = new Date(product.created_at).toLocaleString("pt-BR", { dateStyle: "short" });
  productTableBody.insertAdjacentHTML(
    "beforeend",
    `<tr data-product-id=${product.id}>
    <th scope="row">${product.title}</th>
    <td>${product.category}</td>
    <td>${product.rating}</td>
    <td>${price}</td>
    <td>${dateCreated}</td>
    <td><a><i class="far fa-edit"></i></a>  /  <a class="product-del"data-product-id=${product.id}><i class="far fa-trash-alt"></i></a></td>
    </tr>`
  );
}

export { fetchProductsApi };
