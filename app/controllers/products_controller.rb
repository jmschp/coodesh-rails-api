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

  private

  def set_product
    @product = Product.find(params[:id])
    authorize @product  # For Pundit
  end

  def product_params
    params.require(:product).permit(:title, :category, :price, :rating)
  end
end
