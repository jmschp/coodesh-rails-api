class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_product, only: %i[edit update destroy]

  def index
    @products = policy_scope(Product)
    authorize @products
  end

  def edit
  end

  def update
    @product.update(product_params)
    redirect_to root_path
  end

  def destroy
    # raise
    # @product.destroy
    RestClient.delete("#{api_v1_products_url}/#{@product.id}", set_http_headers)
    redirect_to root_path, notice: "Product deleted"
  end

  def upload_validation
    body = file_format_validation
    if body.present?
      request = RestClient.post(api_v1_products_url, body.to_json, set_http_headers({ content_type: :json, accept: :json }))

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
    params.require(:product).permit(:title, :category, :price, :rating, :image)
  end

  def file_format_validation
    if params.key?(:file) && params[:file].content_type == "application/json"
      uploaded_file = params[:file]
      serialized_products = uploaded_file.tempfile.read
      JSON.parse(serialized_products)
    end
  end

  def set_http_headers(args = {})
    headers = {
      x_user_email: current_user.email,
      x_user_token: current_user.reload.authentication_token
    }
    if args.empty?
      headers
    else
      headers.merge(args)
    end
  end
end
