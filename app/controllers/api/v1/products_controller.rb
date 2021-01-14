class Api::V1::ProductsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = policy_scope(Product)
  end

  def show
  end

  def create
    binding.pry
    if product_params.is_a?(Array)
      product_params.each do |product_item|
        product_item[:category] = params['type']
        @product = Product.new(product_item)
        authorize @product
        if @product.save
          render :index
        else
          render_error
        end
      end
    else
      product_item = product_params
      product_item[:category] = params['type']
      @product = Product.new(product_item)
      authorize @product
      if @product.save
        render :show, status: :created
      else
        render_error
      end
    end
  end

  def update
    if @product.update(product_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  def api_status
    status = response.code
    message = "Ruby on Rails Challenge 20200810"
    @api_status = { status: status, message: message }
  end

  private

  def set_product
    @product = Product.find(params[:id])
    authorize @product  # For Pundit
  end

  def product_params
    params.permit(_json: [:title, :type, :description, :price, :rating]) if params.key?('_json')
    params.require(:product).permit(:title, :type, :description, :price, :rating)
  end

  def render_error
    render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
  end
end
