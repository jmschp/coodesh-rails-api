require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "upload file" do
    file_path = "#{Rails.root}/test/fixtures/files/products-test.json"
    json_file = fixture_file_upload("#{Rails.root}/test/fixtures/files/products-test.json",'application/json')
    post upload_validation_url,
      params: { file: json_file },
      headers: {
      content_type: "application/json"
    }
    assert_response 201
    assert_equal root_path, page.current_path
  end
end
