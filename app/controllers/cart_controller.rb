class CartController < ApplicationController
  before_action :initialize_cart

  def show
    @cart_items = cart_items
    @cart_total_cents = cart_total_cents
  end

  def add
    product = Product.find(params[:id])

    session[:cart][product.id.to_s] ||= 0
    session[:cart][product.id.to_s] += 1

    redirect_to cart_path, notice: "#{product.name} was added to your cart."
  end

  def update
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i

    if quantity.positive?
      session[:cart][product.id.to_s] = quantity
      redirect_to cart_path, notice: "Cart quantity updated."
    else
      session[:cart].delete(product.id.to_s)
      redirect_to cart_path, notice: "#{product.name} was removed from your cart."
    end
  end

  def remove
    product = Product.find(params[:id])
    session[:cart].delete(product.id.to_s)

    redirect_to cart_path, notice: "#{product.name} was removed from your cart."
  end

  def clear
    session[:cart] = {}

    redirect_to cart_path, notice: "Cart cleared."
  end

  private

  def initialize_cart
    session[:cart] ||= {}
  end

  def cart_items
    Product.where(id: session[:cart].keys).map do |product|
      quantity = session[:cart][product.id.to_s].to_i

      {
        product: product,
        quantity: quantity,
        line_total_cents: product.price_cents * quantity
      }
    end
  end

  def cart_total_cents
    cart_items.sum { |item| item[:line_total_cents] }
  end
end