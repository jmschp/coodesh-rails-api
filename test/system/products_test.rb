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

  # test "upload file" do
  #   # visit root_path
  #   # click_on "Choose File"
  #   #  login_as users(:george)

  #   file_path = "#{Rails.root}/test/fixtures/files/products-test.json"
  #   json_file = fixture_file_upload("#{Rails.root}/test/fixtures/files/products-test.json",'application/json')
  #   post upload_validation_url,
  #     params: { file: json_file },
  #     headers: {
  #     content_type: "application/json"
  #   }
  #   assert_response 201
  # end
end
