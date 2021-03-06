// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { fetchProductsApi } from "./fetch_products_api";
import { postProductsForm } from "./post_products_form";
import { deleteApi } from "./fetch_delete_product";
import { editProduct } from "./fetch_edit_product";
import { editProductImage } from "./fetch_upload_image";


document.addEventListener("turbolinks:load", () => {
  fetchProductsApi("/api/v1/products", deleteApi, editProduct, editProductImage);
  postProductsForm();
});