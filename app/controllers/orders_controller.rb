class OrdersController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find(params[:product_id])
    quantity = params[:order][:quantity].to_i

    if quantity > @product.stock
      redirect_to @product, alert: "Not enough stock available."
      return
    end

    @order = current_user.buyer.orders.build(product: @product, quantity: quantity, total_price: @product.price * quantity)

    if @order.save
      # Décrémenter le stock du produit
      @product.update(stock: @product.stock - quantity)
      redirect_to @product, notice: "Order successfully placed."  # Redirection vers le produit après la commande
    else
      redirect_to @product, alert: "Failed to place order."
    end
  end
end
