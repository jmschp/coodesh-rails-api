require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "upload file" do
    # visit root_path
    # click_on "Choose File"
    #  login_as users(:george)

    file_path = "#{Rails.root}/test/fixtures/files/products-test.json"
    json_file = fixture_file_upload("#{Rails.root}/test/fixtures/files/products-test.json",'application/json')
    post upload_validation_url,
      params: { file: json_file },
      headers: {
      content_type: "application/json"
    }
    assert_response 201
  end
end
