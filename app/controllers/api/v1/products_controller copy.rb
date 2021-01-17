class Api::V1::ProductsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_product, only: %i[show update destroy]

  def index
    @products = policy_scope(Product)
    authorize @products
  end

  def show
  end

  def create
    if params.key?('_json')
      create_multiple_products
    elsif params['commit'] == "Uplaod file"
      create_from_file
    else
      create_single_product
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
    # head :no_content
    render json: { message: "1 product destroyed" }
  end

  def api_status
    status = response.code
    message = "Ruby on Rails Challenge 20200810"
    @api_status = { status: status, message: message }
    # authorize @api_status
  end

  private

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end

  def product_params
    if params.key?('_json')
      params.permit(_json: %i[title type description filename height width price rating])
    else
      params.require(:product).permit(:title, :type, :description, :filename, :height, :width, :price, :rating)
    end
  end

  def render_error
    render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
  end

  def create_multiple_products
    product_saved_count = []
    product_unsaved_count = []
    product_params['_json'].each do |product_item|
      product_item[:category] = product_item.delete :type
      @product = Product.new(product_item)
      authorize @product
      if @product.save
        product_saved_count << product_item
      else
        product_item[:errors] = @product.errors.full_messages
        product_unsaved_count << product_item
      end
    end
    render json: {
      products_uploaded: product_params['_json'].length,
      products_saved: product_saved_count.length,
      products_saved_count: product_saved_count,
      products_unsaved: product_unsaved_count.length,
      products_unsaved_count: product_unsaved_count
    }
  end

  def create_single_product
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

  def create_from_file
    product_saved_count = []
    product_unsaved_count = []
    body = file_format_validation
    if body.present?
      body.each do |product_item|
        product_item[:category] = product_item.delete 'type'
        @product = Product.new(product_item)
        authorize @product
        if @product.save
          product_saved_count << product_item
        else
          product_item[:errors] = @product.errors.full_messages
          product_unsaved_count << product_item
        end
      end
      redirect_to root_path, notice: "Uploaded: | Saved: "
    else
      @product = Product.new()
      authorize :create
      redirect_to root_path, alert: "Invalid file"
    end
  end

  def file_format_validation
    if params.key?(:file) && params[:file].content_type == "application/json"
      uploaded_file = params[:file]
      serialized_products = uploaded_file.tempfile.read
      JSON.parse(serialized_products)
    end
  end
end
