class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy]

  def edit
  end

  def update
    @product.update(product_params)
    redirect_to root_path
  end

  def destroy
    @product.destroy
    redirect_to root_path, notice: "Product deleted"
  end

  def upload_validation
    headers = {
      content_type: :json,
      accept: :json,
      x_user_email: current_user.email,
      x_user_token: current_user.reload.authentication_token
    }
    body = file_format_validation
    if body.present?
      request = RestClient.post("http://localhost:3000#{api_v1_products_path}", body.to_json, headers)
      json_response = JSON.parse(request.body)

      flash[:notice] = "Uploaded: #{json_response['products_uploaded']} | Saved: #{json_response['products_saved']}"
      redirect_to root_path
    else
      redirect_to root_path, alert: "Invalid file"
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
    authorize @product # For Pundit
  end

  def product_params
    params.require(:product).permit(:title, :category, :price, :rating)
  end

  def file_format_validation
    if params.key?(:file) && params[:file].content_type == "application/json"
      uploaded_file = params[:file]
      serialized_products = uploaded_file.tempfile.read
      JSON.parse(serialized_products)
    end
  end
end
