import { csrfToken } from "@rails/ujs";

function fetchWithAuth(url, options = {}) {
  options.headers = {
    "X-CSRF-Token": csrfToken(),
    ...options.headers,
  };
  options.credentials = "same-origin";
  console.log(url, options.headers);
  return fetch(url, options);
}

export { fetchWithAuth };
