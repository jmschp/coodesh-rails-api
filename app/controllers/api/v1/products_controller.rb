class Api::V1::ProductsController < Api::V1::BaseController
  before_action :set_restaurant, only: [ :show ]

  def index
    @products = policy_scope(Product)
  end

  def show
  end

  def api_status
    status = response.code
    message = "Ruby on Rails Challenge 20200810"
    @api_status = { status: status, message: message }
  end

  private

  def set_restaurant
    @product = Product.find(params[:id])
    authorize @product  # For Pundit
  end
end
