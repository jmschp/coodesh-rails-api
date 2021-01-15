require 'json'

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
    redirect_to root_path
  end

  def upload_validation
    headers = {'Content-type': 'application/json', 'X-User-Email': current_user.email, 'X-User-Token': current_user.reload.authentication_token }
    body = file_format_validation
    raise
    redirect_to(api_v1_path, headers: headers, body: body)
  end

  private

  def set_product
    @product = Product.find(params[:id])
    authorize @product # For Pundit
  end

  # def product_params
  #   params.require(:product).permit(:title, :category, :price, :rating)
  # end

  def file_format_validation
    uploaded_file = params[:file]
    # file_path = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
    serialized_products = File.read(uploaded_file.tempfile)
    JSON.parse(serialized_products)
  end
end
