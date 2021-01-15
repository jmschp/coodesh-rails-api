class Api::V1::ProductsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_product, only: %i[show update destroy]

  def index
    @products = policy_scope(Product)
  end

  def show
  end

  def create
    create_products
  end

  # def self.upload_json
  #   create_products
  # end

  def update
    if @product.update(product_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @product.destroy
    # head :no_content
    render json: { message: "1 product destroyed" }
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
    if params.key?('_json')
      params.permit(_json: %i[title type description price rating])
    else
      params.require(:product).permit(:title, :type, :description, :price, :rating)
    end
  end

  def render_error
    render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
  end

  def create_products
    if params.key?('_json')
      product_count = 0
      product_params['_json'].each do |product_item|
        product_item[:category] = product_item.delete :type
        @product = Product.new(product_item)
        authorize @product
        if @product.save
          product_count += 1
        else
          render_error
          break
        end
      end
      render json: { products_uploaded: product_params['_json'].length, products_saved: product_count }
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
end
