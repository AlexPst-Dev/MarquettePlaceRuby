class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    if current_user.seller.nil?
      current_user.create_seller
    end

    @product = current_user.seller.products.build(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      flash.now[:alert] = 'There was an error creating the product.'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      flash.now[:alert] = 'There was an error updating the product.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

  def authorize_seller
    unless current_user.seller == @product.seller
      redirect_to products_path, alert: "You are not authorized to edit this product."
    end
  end
end
