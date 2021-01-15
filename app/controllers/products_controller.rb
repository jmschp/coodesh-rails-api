class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
    # authorize @product  # For Pundit
  end
end
