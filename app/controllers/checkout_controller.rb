class CheckoutController < ApplicationController
  before_action :initialize_cart

  def new
    @provinces = Province.order(:name)
    @cart_items = cart_items
    @subtotal_cents = cart_total_cents

    redirect_to cart_path, alert: "Your cart is empty." if @cart_items.empty?
  end

  def create
    if session[:cart].blank?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    province = Province.find(params[:province_id])

    customer = Customer.create!(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      street: params[:street],
      city: params[:city],
      postal_code: params[:postal_code],
      province: province
    )

    subtotal = cart_total_cents
    gst = (subtotal * province.gst_rate).round.to_i
    pst = (subtotal * province.pst_rate).round.to_i
    hst = (subtotal * province.hst_rate).round.to_i
    total = subtotal + gst + pst + hst

    order = Order.create!(
      customer: customer,
      province: province,
      status: "new",
      subtotal_cents: subtotal,
      gst_cents: gst,
      pst_cents: pst,
      hst_cents: hst,
      total_cents: total
    )

    cart_items.each do |item|
      OrderItem.create!(
        order: order,
        product: item[:product],
        quantity: item[:quantity],
        unit_price_cents: item[:product].price_cents,
        line_total_cents: item[:line_total_cents]
      )
    end

    session[:cart] = {}

    redirect_to order_path(order), notice: "Order was created successfully."
  end

  def show
    @order = Order.includes(order_items: :product).find(params[:id])
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