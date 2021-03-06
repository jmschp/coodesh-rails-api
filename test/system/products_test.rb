require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_path
    assert_selector "h1", text: "Home"
    assert_selector "p", text: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Debitis officiis architecto deleniti modi veritatis odit, ea ex laboriosam maiores corporis voluptatum itaque. Praesentium, illum itaque voluptatem molestias inventore sit repellat!"
  end

  test "check product count" do
    visit root_path
    assert_selector "h2", text: "#{Product.count} products"
  end
end
